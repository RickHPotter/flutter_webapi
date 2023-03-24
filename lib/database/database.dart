import 'package:flutter/cupertino.dart';
import 'package:flutter_webapi_first_course/models/dao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  Future<String> getDBName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return 'journal${preferences.getInt("id").toString()}.db';
  }

  Future<Database> initDB(String from) async {
    String path = await getDatabasesPath();
    String databaseName = await getDBName();
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA $databaseName");
    var db = await openDatabase(
      join(path, databaseName),
      onCreate: (db, version) async => await db.execute(Dao.tableSQL),
      version: 1
    );
    debugPrint('[DB] from $from.');
    return db;
  }
}