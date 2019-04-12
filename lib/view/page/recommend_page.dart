import 'package:flutter/material.dart';
import 'package:konayan/notifier/pref_notifier.dart';
import 'package:konayan/view/page/Konachan_post_page.dart';
import 'package:provider/provider.dart';
class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    var pref=Provider.of<PrefNotifier>(context);
    return  Builder(builder: (context){
      if(pref.restrict.isNotEmpty){
        return  KonachanPostPage(tag: null,allowList: pref.restrict);
      }
      return Center(child: Text("?"),);
    });
  }

  @override
  bool get wantKeepAlive => true;
}