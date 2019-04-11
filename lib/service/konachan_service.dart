import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:konayan/api/konachan_api.dart';
import 'package:konayan/model/post.dart';
import 'package:konayan/model/tag.dart';

final Dio dio = Dio()..options = BaseOptions(baseUrl: 'https://yande.re');
final KonachanService apiSvc=KonachanService();
class KonachanService implements KonachanApi {
  @override
  Future<List<Post>> getPosts({int page, int limit, String tag}) async {
    var pageP = page == null ? '' : 'page=$page';
    var limitP = limit == null ? '' : 'limit=$limit';
    var tagP =page==null? 'tags=$tag':'&tags=$tag';
    tagP=tag==null?'':tagP;
    print('/post.json?' + pageP + limitP + tagP);
    var response = await dio.get('/post.json?' + pageP + limitP + tagP);
    List<dynamic> postsData = response.data;
    var posts = postsData.map((f) => Post.fromJson(f)).toList();
    return posts;
  }

  @override
  Future<List<Tag>> getTags() async {
    var response = await dio.get('/tag.json?order=count');
    List<dynamic> tagsData=response.data;
    var tags=tagsData.map((f)=>Tag.fromJson(f)).toList();
    return tags;
  }
}
