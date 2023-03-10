import 'package:flutter/cupertino.dart';
import 'package:flutter_webapi_first_course/models/dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  Future<Database> initDB(String from) async {
    String path = await getDatabasesPath();
    var db = await openDatabase(
      join(path, 'journal.db'),
      onCreate: (db, version) async => await db.execute(Dao.tableSQL),
      version: 1
    );
    debugPrint('[DB] from $from.');
    return db;
  }
}