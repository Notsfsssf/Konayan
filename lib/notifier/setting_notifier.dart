import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konayan/service/konachan_service.dart';
class SettingNotifier extends ChangeNotifier {
  String _storagePath;
  String _domain = '';
  String get domain => _domain;
  String get storagePath => _storagePath;
  SharedPreferences prefs;
  static const String STORAGEPATH = 'storagepath';
  set domain(String value) {
    _domain = value;
    prefs.setString("domain", value);
    notifyListeners();
  }

  set storagePath(String value) {
    _storagePath = value;
    prefs.setString(STORAGEPATH, value);
    notifyListeners();
  }

  int _option;

  int get option => _option;

  set option(int value) {
    _option = value;
    switch (value) {
      case 0:
        dio.options.baseUrl = 'https://yande.re';
        break;
      case 1:
        dio.options.baseUrl = 'https://konachan.net';
        break;
    }
    prefs.setInt('option', value);
    notifyListeners();
  }

  fetchData() async {
    prefs = await SharedPreferences.getInstance();
    try {
      _storagePath = prefs.getString(STORAGEPATH);
      _option = prefs.getInt('option');
      _domain=prefs.getString('domain');
      if (_option == null) {
        _option = 0;
      }
      if (_storagePath == null) {
        throw Exception("s");
      }
      if(_domain==null){
        _domain='';
      }
    } catch (e) {
      Directory appDocDir = await getExternalStorageDirectory();
      String appDocPath = '${appDocDir.path}/DCIM/konayan/'; // 应用文件夹
      _storagePath = appDocPath;
    } finally {
      notifyListeners();
    }
  }
}
