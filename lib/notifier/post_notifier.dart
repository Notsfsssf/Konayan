import 'package:flutter/material.dart';
import 'package:konayan/model/post.dart';
import 'package:konayan/service/konachan_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostNotifier extends ChangeNotifier {
  List<Post> _posts;
  List<String> _selectList;
  List<String> get selectList => _selectList;
  bool _loadMoreIng=false;
  get loadMoreIng=>_loadMoreIng;
  bool _loadMoreEnd=false;
  get loadMoreEnd=>_loadMoreEnd;
  set selectList(List<String> value) {
    _selectList = value;
    notifyListeners();
  }
  List<Post> get posts => _posts;

  set posts(List<Post> value) {
    _posts = value;
    notifyListeners();
  }

  Future<bool> setPosts({String tag}) async {
    posts = await apiSvc?.getPosts(tag: tag);
    return posts.isNotEmpty;
  }

  Future loadMore({int page, String tag}) async {
    _loadMoreIng=true;
    notifyListeners();
    final addPost = await apiSvc?.getPosts(page: page, tag: tag);
    _posts.addAll(addPost);
    _loadMoreEnd=addPost?.isEmpty;
    _loadMoreIng=false;
    notifyListeners();
  
  }


  void changeSelect(int index, bool v) {
    const List a = ['s', 'q', 'e'];
    if (v) {
      if (!_selectList.contains(a[index])) _selectList.add(a[index]);
    } else {
      if (_selectList.contains(a[index])) _selectList.remove(a[index]);
    }
    notifyListeners();
  }
}
