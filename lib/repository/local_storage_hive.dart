import 'dart:async';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageHive {
  Completer<Box> _instance = Completer<Box>();

  static final LocalStorageHive _localStorageHive = LocalStorageHive._internal();

  factory LocalStorageHive(){
    return _localStorageHive;
  }

  LocalStorageHive._internal(){
    _init();
  }

  _init() async {
    var path = Directory.current.path;
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    var box = await Hive.openBox('db');
    _instance.complete(box);
  }

  Future saveToken(String token) async{
    var box = await _instance.future;
    box.put('token', token);
  }

  Future<String> getToken() async{
    var box = await _instance.future;
    return box.get('token');
  }

  Future<void> deleteToken() async {
    var box = await _instance.future;
    return box.delete('token');
  }
}