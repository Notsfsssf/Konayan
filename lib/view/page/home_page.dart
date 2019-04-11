import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konayan/view/page/konachan_search_page.dart';
import 'package:konayan/view/page/recommend_page.dart';
import 'package:konayan/view/page/setting_page.dart';
import 'package:konayan/view/page/website_page.dart';
import 'package:konayan/view/widget/bottom_navy_bar.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  int _selectedIndex = 0;

  PageController _pageController;
  final _widgetOptions = [
    RecommendPage(),
    KonachanSearchPage(),
    WebSitePage(),
    SettingPage(),
  ];

  @override
  void initState() {
    _pageController = new PageController(initialPage: 0);
    super.initState();
    loadData();
    checkPerMission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset('asset/images/mahou_teriri.jpg'),
              ),
            ),
           
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
              ListTile(
              title: Text('Creator'),
              subtitle: Text('Perol_Notsfsssf'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Beta-version'),
              subtitle: Text('No.525300887039'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Feedback E-mail'),
              subtitle: Text('PxEzFeedBack@outlook.com'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
             ListTile(
              title: Text('Made with'),
              subtitle: Text('Flutter'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            //  ListTile(leading: Image.asset('asset/images/mahou_teriri.jpg'),),
          ],
        ),)
      ),
      appBar: AppBar(
        elevation: _selectedIndex == 1 ? 0 : null,
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        title: Text('Konayan'),
        actions: <Widget>[
          PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                      value: 'value01',
                      child: Text("Nobody here but us chickens!"),
                    )
                  ],
              onSelected: (String value) {
                setState(() {});
              })
        ],
      ),
      body: PageView.builder(
        itemCount: 4,
        onPageChanged: (index) {
          setState(() {
            if (_selectedIndex != index) _selectedIndex = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return _widgetOptions.elementAt(index);
        },
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) => setState(() {
              _selectedIndex = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            inactiveColor: Colors.grey,
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
              inactiveColor: Colors.grey,
              activeColor: Colors.purpleAccent),
          BottomNavyBarItem(
              icon: Icon(Icons.web),
              title: Text('WebSite'),
              inactiveColor: Colors.grey,
              activeColor: Colors.pink),
          BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              inactiveColor: Colors.grey,
              activeColor: Colors.blue),
        ],
      ),
    );
  }

  Future checkPerMission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
    }
  }

  Future loadData() async {}

  Widget _getBottomDrawer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('asset/images/yander_logo.png'),
              ),
              title: Text("Camera"),
              onTap: () async {},
              trailing: Icon(Icons.settings),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text("Camera"),
              onTap: () async {},
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
              onTap: () async {},
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Divider(),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
              onTap: () async {},
            ),
          ],
        )
      ],
    );
  }
}

