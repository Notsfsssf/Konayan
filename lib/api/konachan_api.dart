import 'package:konayan/model/post.dart';
import 'package:konayan/model/tag.dart';

abstract class KonachanApi {
  Future<List<Post>> getPosts();
  Future<List<Tag>> getTags();
}