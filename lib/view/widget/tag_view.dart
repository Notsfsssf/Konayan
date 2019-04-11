import 'package:flutter/material.dart';
import 'package:konayan/model/tag.dart';
import 'package:konayan/notifier/db_notifier.dart';
import 'package:konayan/view/page/result_page.dart';
import 'package:provider/provider.dart';

class TagView extends StatefulWidget {
  List<Tag> tags = [];

  TagView({Key key, this.tags}) : super(key: key);

  @override
  _TagViewState createState() => _TagViewState();
}

class _TagViewState extends State<TagView> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _textTag(String value) {
    final word = value.replaceAll("#", "");
    return Consumer<DbNotifier>(
      builder: (BuildContext context, DbNotifier v) => GestureDetector(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Delete"),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              v.deleteTag(value);
                              Navigator.of(context).pop();
                            },
                            child: Text("CONFIRM")),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("CANCEL")),
                      ],
                    );
                  });
            },
            child: ActionChip(
              label: Text(word),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return new ResultPage(
                    word: word,
                  );
                }));
              },
            ),
          ),
    );
  }

  _buildTagList(List<Tag> tags) {
    List<Widget> tagWidgets = [];
    if (tags != null) tags.forEach((v) => {tagWidgets.add(_textTag(v.name))});
    return tagWidgets;
  }

  Widget _tagLand(List<Tag> tags) {
    return Wrap(
      spacing: 5,
      alignment: WrapAlignment.center,
      children: _buildTagList(tags),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _tagLand(widget.tags);
  }
}
