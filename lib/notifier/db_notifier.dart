import 'package:flutter/material.dart';
import 'package:konayan/model/tag.dart';
import 'package:konayan/service/sql_service.dart';
import 'package:objectdb/objectdb.dart';

class DbNotifier extends ChangeNotifier {
  List<String> _tags = [];
  ObjectDB db;

  fetchData() async {
    db = await SqlService.db();
    final value = await db.find({'name': 'tags'});
    _tags.length = 0;
    value.forEach((v) {
      String tag = v['tags'];
      _tags.add(tag);
    });
    notifyListeners();
  }

  List<String> get tags {
    return _tags;
  }

  set tags(List<String> value) {
    _tags = value;
    notifyListeners();
  }

  insertTag(String value) async {
    db.insert({'tags': value, 'name': 'tags'}).then((_) {
      _tags.add(value);
      notifyListeners();
    });
  }

  Future deleteTag(String value) async {
 final a= await   db.remove({'tags':value, 'name': 'tags'});
  print({'tags':value, 'name': 'tags'});
  _tags.remove(value);
  notifyListeners();
  }
}
