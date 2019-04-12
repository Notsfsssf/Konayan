import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class DetailNotifier extends ChangeNotifier {
  final a = ['yande', 'konachan'];

  Future<String> saveToGallery(String fileUrl, String name, String storagePath,int option) async {
    print(fileUrl);
    var files = await DefaultCacheManager().getSingleFile(fileUrl);
    String appDocPath=storagePath;
    option=option??0;
    String webSite = a[option];
    String type = fileUrl.contains('png') ? 'png' : 'jpg';
    File file = File('$appDocPath${webSite}_$name.$type');
    print('$appDocPath${webSite}_$name.$type');
    if (!(await file.exists()))
      file.createSync(recursive: true);
    else
      return null;
    files.copy(file.path);
    return file.uri.path;
  }

  Future<String> reSaveToGallery(String fileUrl, String name, String storagePath,int option) async {
    print(fileUrl);
    var files = await DefaultCacheManager().getSingleFile(fileUrl);
    String appDocPath=storagePath;
    option=option??0;
    String webSite = a[option];
    String type = fileUrl.contains('png') ? 'png' : 'jpg';
    File file = File('$appDocPath${webSite}_$name.$type');
    print('$appDocPath${webSite}_$name.$type');
    if (!(await file.exists())) file.createSync(recursive: true);
    files.copy(file.path);
    return file.uri.path;
  }
}
