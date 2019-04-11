import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:konayan/notifier/post_notifier.dart';
import 'package:konayan/view/page/konachan_detail_page.dart';
import 'package:konayan/view/widget/super_drawer.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class KonachanPostPage extends StatefulWidget {
  final String tag;
  final List<String> allowList;
  static const List<String> a = ['s', 'q', 'e'];
  KonachanPostPage({Key key, this.tag, this.allowList = a}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _KonachanPostState();
  }
}

class _KonachanPostState extends State<KonachanPostPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController;
  PostNotifier _viewModel;
  int page;
  bool loadMoreIng;

  @override
  void initState() {
    loadMoreIng = false;
    page = 1;
    _viewModel = PostNotifier();
    _viewModel.selectList = widget.allowList;
    _viewModel.setPosts(tag: widget.tag);
    _scrollController = new ScrollController()
      ..addListener(() async {
        bool down = _scrollController.offset ==
            _scrollController.position.maxScrollExtent;
        if (down && !_viewModel.loadMoreIng) {
          await _viewModel.loadMore(page: ++page, tag: widget.tag);
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostNotifier>(
      notifier: _viewModel,
      child: Consumer<PostNotifier>(builder: (context, value) {
        if (value.posts == null)
          return Center(
            child: CircularProgressIndicator(),
          );
        return _buildList();
      }),
    );
  }

  Widget _buildBody(PostNotifier value) {
    return Stack(
      children: <Widget>[
        RefreshIndicator(
          child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            crossAxisCount: 4,
            itemCount: value.posts == null ? 0 : value.posts.length,
            itemBuilder: (BuildContext context, int index) {
              if (widget.allowList.contains(value.posts[index].rating))
                return InkWell(
                    onLongPress: () {},
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (BuildContext context) {
                          return new KonachanDetailPage(
                            post: value.posts[index],
                          );
                        }),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Hero(
                        child: FadeInImage.memoryNetwork(
                          fit:BoxFit.fitWidth ,
                            placeholder: kTransparentImage,
                            image: value.posts[index].previewUrl),
                        tag: value.posts[index].previewUrl,
                      ),
                    ));
              else
                return Container();
            },
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
          ),
          onRefresh: () => _viewModel.setPosts(tag: widget.tag),
        ),
  
           Align(
          alignment: Alignment.bottomCenter,child:
        Visibility(
          child: Text("LoadMoreEnd"),
          visible: value.loadMoreEnd,
        )),
        Align(
          alignment: Alignment.bottomCenter,
          child:  Visibility(
          child: LinearProgressIndicator(),
          visible: value.loadMoreIng,
        ),
        )
      ],
    );
  }

  static const List a = ['s', 'q', 'e'];

  Widget _buildDrawer(PostNotifier value) {
    const List a = ['s', 'q', 'e'];
    return DrawerController(
      child: SuperDrawer(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: a.length + 1,
                  itemBuilder: (context, int index) {
                    if (index == 0)
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Restrict",
                              style: TextStyle(),
                            ),
                          ),
                          Divider()
                        ],
                      );
                    else
                      return CheckboxListTile(
                        title: Text(a[index - 1]),
                        value: value.selectList.contains(a[index - 1]),
                        onChanged: (bool v) {
                          value.changeSelect(index - 1, v);
                        },
                      );
                  }),
            )
          ],
        ),
      ),
      drawerCallback: (v) {},
      alignment: DrawerAlignment.end,
    );
  }

  Widget _buildList() {
    return ChangeNotifierProvider<PostNotifier>(
      child: Consumer<PostNotifier>(
        builder: (BuildContext context, PostNotifier value) {
          return Stack(
              children: <Widget>[_buildBody(value), _buildDrawer(value)]);
        },
      ),
      notifier: _viewModel,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
