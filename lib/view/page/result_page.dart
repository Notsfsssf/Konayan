import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konayan/model/tag.dart';
import 'package:konayan/notifier/db_notifier.dart';
import 'package:konayan/notifier/pref_notifier.dart';
import 'package:konayan/view/page/Konachan_post_page.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatefulWidget {
  final String word;

  ResultPage({Key key, @required this.word}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var value = Provider.of<PrefNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.word),
          actions: <Widget>[
            Consumer<DbNotifier>(builder: (context, value) {
              bool book = false;
              value.tags.forEach((v) {
                if (v == widget.word) {
                  book = true;
                }
              });
              return IconButton(
                icon: Icon(!book ? Icons.bookmark_border : Icons.bookmark),
                onPressed: () async {
                  if (!book)
                    value.insertTag(widget.word);
                  else {
                    value.deleteTag(widget.word);
                  }
                },
              );
            }),
          ],
        ),
        body: _buildBody(value));
  }

  _buildBody(value) => Builder(builder: (context) {
        if (value.restrict.isEmpty) return Center();
        return KonachanPostPage(
          tag: widget.word,
          allowList: value.restrict,
        );
      });
}
