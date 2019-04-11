import 'package:objectdb/objectdb.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SqlService {
  static ObjectDB _db;

  static Future<ObjectDB> db() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, 'demo.db');
    _db = ObjectDB(path);
    _db.open();
    return _db;
  }
}
