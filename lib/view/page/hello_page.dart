import 'package:flutter/material.dart';
import 'package:konayan/notifier/setting_notifier.dart';
import 'package:konayan/view/page/home_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HelloPage extends StatefulWidget {
  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  TextEditingController _textDomainController;
  @override
  void initState() {
    _textDomainController = TextEditingController();

    _isExpanded = false;
    super.initState();
  }

  bool _isExpanded;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          const url = 'https://flutter.dev';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(80),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                print(isExpanded);
                setState(() {
                  _isExpanded = !isExpanded;
                });
              },
              children: <ExpansionPanel>[
                ExpansionPanel(
                    body: Consumer<SettingNotifier>(builder: (BuildContext context, SettingNotifier value) {
                      return _buildDomainCard(context,value);
                    },),
                    isExpanded: _isExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                icon: Icon(Icons.home),
                                hintText: 'No need to input here',
                                labelText: 'Hello *',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            RaisedButton(
                              child: Text(
                                "Hi",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text(
                                              "Nobody here but us chickens!"),
                                          content: Text(
                                              "You need to find more useful clues."),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("CONFIRM"),
                                              onPressed: () {},
                                            )
                                          ],
                                        ));
                              },
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildDomainCard(context, SettingNotifier value) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _textDomainController,
              decoration: const InputDecoration(
                icon: Icon(Icons.web_asset),
                hintText: 'Website name?',
                labelText: 'Domain *',
              ),
              validator: (String value) {
                return value.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            RaisedButton(
              child: Text(
                "Enter",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                var text = _textDomainController.text;
                if (text == 'konachan.net' || text == 'yande.re') {
                  value.domain = text;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyHomePage(
                                title: "d",
                              )));
                }
              },
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      );
}
