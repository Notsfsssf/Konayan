import 'package:flutter/material.dart';
import 'package:konayan/service/konachan_service.dart';
import 'package:konayan/model/tag.dart';
class SearchNotifier extends ChangeNotifier {
    List<Tag> _tags;

  List<Tag> get tags => _tags;
  set tags(List<Tag> value) {
    _tags = value;
    notifyListeners();
  }
  Future<bool> fetchData() async {
    tags = await apiSvc.getTags();
    return tags.isNotEmpty;
  }
}
