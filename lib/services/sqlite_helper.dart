import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper? _instance;
  static late Database db;

  DBHelper._();

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'users_demo.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE courses (
              course_name TEXT NOT NULL,
            ),
          """,
        );
        await database.execute(
          """
            CREATE TABLE course_grades (
              course_name TEXT NOT NULL,
              name TEXT NOT NULL,
              date_due TEXT,
              score TEXT,
              impact TEXT,
              category TEXT NOT NULL
            ),
          """,
        );
        await database.execute(
          """
            CREATE TABLE assignments (
              course_name TEXT NOT NULL,
              name TEXT NOT NULL,
              date_due TEXT,
              score TEXT,
              impact TEXT,
              category TEXT NOT NULL
            ),
          """,
        );
      },
      version: 1,
    );
  }
  
  static Future<DBHelper> getInstance() async {
    
    if (_instance == null) {
      _instance = DBHelper._();
      await _instance!.initDB();
    }

    return _instance!;
  }
  
}