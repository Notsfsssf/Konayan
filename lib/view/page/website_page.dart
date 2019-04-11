import 'package:flutter/material.dart';
import 'package:konayan/notifier/setting_notifier.dart';
import 'package:provider/provider.dart';

class WebSitePage extends StatefulWidget {
  @override
  _WebSitePageState createState() => _WebSitePageState();
}

class _WebSitePageState extends State<WebSitePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingNotifier>(
      builder: (context, value) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    value.option = 0;
                  },
                  child: Container(
                    decoration:value.option==0? BoxDecoration(
                        color: Colors.grey,
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]):null,
                    child: Card(
                      child: Image.asset(
                        'asset/images/yander_logo.png',
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  value.option = 1;
                },
                child: Container(
                  decoration:value.option==1? BoxDecoration(
                      color: Colors.grey,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]):null,
                  child: Card(
                    child: Image.asset(
                      'asset/images/konachan_logo.png',
                      height: 80,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
