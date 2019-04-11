import 'package:flutter/material.dart';
import 'package:konayan/notifier/pref_notifier.dart';
import 'package:konayan/notifier/setting_notifier.dart';
import 'package:konayan/view/page/directory_page.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingNotifier>(builder: (context, SettingNotifier value) {
      return bodyData(value);
    });
  }

  Widget bodyData(SettingNotifier value) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "General Setting",
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    
                    title: Text("StoragePath"),
                    subtitle: Text(
                        value.storagePath == null ? '' : value.storagePath),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        // We'll create the SelectionScreen in the next step!
                        MaterialPageRoute(
                            builder: (context) => DirectoryPage(
                                  path: value.storagePath,
                                )),
                      );
                      if (result != null) value.storagePath = result;
                    },
                  ),
                  Consumer<PrefNotifier>(
                    builder: (context, pref) {
                      return ListTile(
                        leading: Icon(
                          Icons.mail,
                          color: Colors.red,
                        ),
                        title: Text('Restrict'),
                        subtitle: Text(pref.restrict.toString()),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () async {
                      var r18on=    pref.pref.getBool('r18on');
                         if(r18on==null){
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Text('Are you At least 18 years old?'),
                                      title: Text('warning!!!'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: new Text("CONFIRM"),
                                      onPressed: () {
                                        pref.pref.setBool('r18on', true);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: new Text("CANCEL"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                    ));
                         }
                          else if(r18on){
                            final result = await showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(
                                    100.0, 200.0, 100.0, 100.0),
                                items: <PopupMenuItem<String>>[
                                  new PopupMenuItem<String>(
                                      value: 's', child: new Text('Safe')),
                                  new PopupMenuItem<String>(
                                      value: 's,q',
                                      child: new Text('Questionable')),
                                  new PopupMenuItem<String>(
                                      value: 's,q,e',
                                      child: new Text('Explicit')),
                                ]);
                            if (result != null) pref.restrict = result.split(',');
                          }
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.sync,
                      color: Colors.blue,
                    ),
                    title: Text("Sync Data"),
                    subtitle: Text("sub"),
              
                    trailing: Icon(Icons.arrow_right),
                  )
                ],
              ),
            ),

            //2
          ],
        ),
      );
}
