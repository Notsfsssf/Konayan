import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:konayan/model/post.dart';
import 'package:konayan/model/tag.dart';
import 'package:konayan/notifier/detail_notifier.dart';
import 'package:konayan/notifier/setting_notifier.dart';
import 'package:konayan/view/page/zoom_page.dart';
import 'package:konayan/view/widget/tag_view.dart';
import 'package:konayan/view/widget/toast.dart';
import 'package:provider/provider.dart';

class KonachanDetailPage extends StatefulWidget {
  Post post;

  KonachanDetailPage({Key key, this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _konachanDetailPageState();
  }
}

class _konachanDetailPageState extends State<KonachanDetailPage> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  Size deviceSize;

  Widget appBarColumn(BuildContext context) => SafeArea(
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                  ),
                  onPressed: () =>
                      Navigator.canPop(context) ? Navigator.pop(context) : null,
                ),
                new IconButton(
                  icon: new Icon(
                    Icons.more_vert,
                    color: Colors.black54,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ],
        ),
      );
  DetailNotifier _detailNotifier;

  @override
  void initState() {
    _detailNotifier = DetailNotifier();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<DetailNotifier>(
        child: Consumer<DetailNotifier>(builder: (context, value) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildBody(value, context),
              appBarColumn(context),
            ],
          );
        }),
        notifier: _detailNotifier,
      ),
    );
  }

  _showSaveDialog(DetailNotifier model, BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
                title: new Text("Title"),
                content: new Text("Save?"),
                actions: <Widget>[
                  FlatButton(
                    child: new Text("CANCEL"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Consumer<SettingNotifier>(builder: (BuildContext contexts, value) {
                  return  FlatButton(
                        child: new Text("OK"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('start download'),));
                          final path = await model.saveToGallery(
                              widget.post.fileUrl, widget.post.id.toString(),value.storagePath,value.option);
                          if (path == null) {
                            if (!mounted) return;
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("already saved"),
                              action: SnackBarAction(
                                  label: "Retry",
                                  onPressed: () async {
                                    final path = await model.reSaveToGallery(
                                        widget.post.fileUrl,
                                        widget.post.id.toString(),value.storagePath,value.option);
                                           if (!mounted) return;
                             Scaffold.of(context).showSnackBar(SnackBar(content: Text("saved"),));
                                  }),
                            ));
                          } else {
                            await platform
                                .invokeMethod('mediaScan', {'uriString': path});
                                 if (!mounted) return;
                                 Scaffold.of(context).showSnackBar(SnackBar(content: Text("saved"),));
                          }
                        },
                      );
                  },)
                ]));
  }

  List<Tag> _computeTags() {
    List<Tag> tags = [];
    widget.post.tags.split(" ").forEach((v) => tags.add(Tag(name: v)));
    return tags;
  }

  Widget _buildBody(DetailNotifier model, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            onLongPress: () async {
              _showSaveDialog(model, context);
            },
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new ZoomPage(widget.post.sampleUrl);
              }));
            },
            child: Hero(
              child: FadeInImage(
                placeholder: NetworkImage(widget.post.previewUrl),
                image: CachedNetworkImageProvider(widget.post.fileUrl),
                fit: BoxFit.fitWidth,
              ),
              tag: widget.post.previewUrl,
            ),
          ),
          Padding(
            child: TagView(
              tags: _computeTags(),
            ),
            padding: EdgeInsets.all(5),
          ),
          ListTile(
            title: Text("Id"),
            subtitle: Text(widget.post.id.toString()),
          ),
          ListTile(
            title: Text("Author"),
            subtitle: Text(widget.post.author),
          ),
          ListTile(
            title: Text("Size"),
            subtitle:
                Text((widget.post.fileSize.toString())),
          ),
          ListTile(
              title: Text("Pixel"),
              subtitle: Text('${widget.post.width}x${widget.post.height}')),
          ListTile(title: Text("Source"), subtitle:Text(widget.post.source)),
          ListTile(title: Text("Rating"), subtitle: Text(widget.post.rating)),
        ],
      ),
    );
  }
}
