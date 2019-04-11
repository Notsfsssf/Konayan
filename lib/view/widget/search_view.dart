import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konayan/view/page/result_page.dart';

class SearchView extends StatefulWidget {
  final TextEditingController controller;

  SearchView({Key key, @required this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchViewState();
  }
}

class _SearchViewState extends State<SearchView> {
  Widget searchCard() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.search),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Find by tag"),
                onSubmitted: (v) {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                    return new ResultPage(word: widget.controller.text,);
                  }));
                },
              ),
            ),
            Icon(Icons.close),
          ],
        ),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return searchCard();
  }
}
