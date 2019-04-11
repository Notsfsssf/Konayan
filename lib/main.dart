import 'package:flutter/material.dart';
import 'package:konayan/notifier/db_notifier.dart';
import 'package:konayan/notifier/pref_notifier.dart';
import 'package:konayan/notifier/setting_notifier.dart';
import 'package:konayan/view/page/hello_page.dart';
import 'package:konayan/view/page/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DbNotifier>(
      child: ChangeNotifierProvider<SettingNotifier>(
        child: ChangeNotifierProvider<PrefNotifier>(
          child:Consumer<SettingNotifier>(builder: (BuildContext context, SettingNotifier value) =>MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch:value.option==0? Colors.deepOrange:Colors.deepPurple,
            ),
            home:value.domain=='konachan.net'||value.domain== 'yande.re'? MyHomePage(title: 'Flutter Home Page'):HelloPage(),
          ), ),
          notifier: PrefNotifier()..fetchData(),
        ),
        notifier: SettingNotifier()..fetchData(),
      ),
      notifier: DbNotifier()..fetchData(),
    );
  }
}

