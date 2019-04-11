import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefNotifier extends ChangeNotifier {
  SharedPreferences pref;
  List<String> _restrict = [];

  List<String> get restrict => _restrict;

  set restrict(List<String> value) {
    if (value.isEmpty) return;
    _restrict = value;
    String result = '';
    for (var i = 0; i < value.length; i++) {
      result += value[i];
      if (i < value.length - 1) {
        result += ',';
      }
    }
    pref.setString('restrict', result);
    print("imok");
    notifyListeners();
  }

  fetchData() async {
    pref = await SharedPreferences.getInstance();
    try {
      _restrict = pref.getString('restrict').split(',');
      if (_restrict == null) {
        throw Exception("s");
      }
    } catch (e) {
      _restrict = ['s'];
    } finally {
      notifyListeners();
    }
  }
}
