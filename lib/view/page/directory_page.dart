import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryPage extends StatefulWidget {
  final String path;

  DirectoryPage({@required this.path});

  @override
  _DirectoryPageState createState() => _DirectoryPageState();
}

class Folder {
  String path;
  String name;
  Folder(this.path, this.name);
}

class _DirectoryPageState extends State<DirectoryPage> {
  String rootPath;
  String nowPath;
  List<Folder> nowFolders = List<Folder>();

  List<Folder> _fetchFiles(String path) {
    List<Folder> folders = List<Folder>();
    try {
      var directory = new Directory(path);
      List<FileSystemEntity> files = directory.listSync();
      for (var f in files) {
        print(f.path);
        var bool = FileSystemEntity.isFileSync(f.path);
        if (!bool) {
          folders.add(Folder(f.path, f.path.replaceAll(f.parent.path+'/', '')));
        }
      }
    } catch (e) {
      print(e);
    }
    return folders;
  }

  @override
  void initState() {
    nowPath = widget.path;
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.replay), onPressed: ()  async {
            Directory appDocDir = await getExternalStorageDirectory();
            var appDocPath = '${appDocDir.path}/DCIM/konayan/';
            Navigator.pop(context,appDocPath);
          },),
          IconButton(icon: Icon(Icons.save), onPressed: () {
            Navigator.pop(context,nowPath+'/');
          },),

        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(child: Column(children: <Widget>[
              Text(nowPath),
              Divider()
            ],),),
            Builder(builder: (context) {
              if (nowFolders == null) {
                return Text("???");
              }
              return Expanded(
                child: ListView.builder(
                    itemCount: nowFolders.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        if(nowPath==rootPath)
                          return Text('');
                        return ListTile(
                          title: Text("..."),
                          onTap: () {
                            nowPath = File(nowPath).parent.path;
                            setState(() {
                              nowPath;
                              nowFolders = _fetchFiles(nowPath);
                            });
                          },
                        );
                      }
                      return ListTile(
                        leading: Icon(Icons.folder),
                        title: Text(nowFolders[index - 1].name),
                        onTap: () {
                          final path = nowFolders[index - 1].path;
                          List<Folder> list = _fetchFiles(path);
                          setState(() {
                            nowFolders = list;
                            nowPath = path;
                          });
                        },
                      );
                    }),
              );
            })
          ],
        ),
      ),
    );
  }

  Future _initData() async {
    final path = await getExternalStorageDirectory();

    rootPath = path.path;
    setState(() {
      nowFolders = _fetchFiles(nowPath);
    });
  }
}
