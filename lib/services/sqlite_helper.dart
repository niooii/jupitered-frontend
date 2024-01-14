import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:jupiter_frontend/models/assignment.dart';
import 'package:jupiter_frontend/models/course.dart';

class DBHelper {
  static DBHelper? _instance;
  static late Database db;

  String name = "";

  get instance => _instance;
  get getName {
    return name;
  }

  DBHelper._();

  Future<void> initDB() async {
    _instance?.loadName();

    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'users_demo.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE courses (
              course_name TEXT NOT NULL
              teacher TEXT NOT NULL
              missing INTEGER NOT NULL
              graded INTEGER NOT NULL
              ungraded INTEGER NOT NULL
              total INTEGER NOT NULL 
            );
          """,
        );
        await database.execute(
          """
            CREATE TABLE course_grades (
              course_name TEXT NOT NULL,
              category TEXT NOT NULL,
              percent_grade REAL,
              fraction_grade TEXT,
              additional_info TEXT
            );
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
            );
          """,
        );
      },
      version: 1,
    );
  }

  Future<List<Course>> getCourses() async {
    List<Course> courses = [];
    List<Map<String, dynamic>> courseMapList = await db.query("courses");
    Map<String, dynamic> courseMap = courseMapList[0];
    print("courseMapList");
    for (var course in courseMapList) {
      print(course);
    }
    print("courseMap");
    for (var course in courseMap.entries) {
      print(course);
    }

    for (var course in courseMapList) {
      List<Assignment> assingments =
          await getAssignments(course["course_name"]);
      List<Map<String, dynamic>> catMap = await db.query("course_grades");
      print(catMap);

      courses.add(Course(
          course["course_name"],
          "teacher",
          assingments,
          catMap[0]["grades"][0]["Course Average"]["percent_grade"],
          catMap[0]));
    }
    return courses;
  }

  Future<List<Assignment>> getAssignments(String course) async {
    List<Assignment> assignments = [];
    List<Map<String, dynamic>> assignmentMap = await db.rawQuery(
        "SELECT * FROM assignments WHERE course_name = 'App Development'");

    for (var assignment in assignmentMap) {
      assignments.add(Assignment.fromMap(assignment));
    }
    return assignments;
  }

  static Future<DBHelper> getInstance() async {
    if (_instance == null) {
      _instance = DBHelper._();
      await _instance!.initDB();
    }

    return _instance!;
  }

  Future<int> storeApiResponse(String json) async {
    try {
      var data = JsonDecoder().convert(json);
      print(
          "storeApiResponse: ${data["courses"][0]["grades"][0]["percent_grade"]}");
      name = data["name"];
      for (var course in data["courses"]) {
        db.insert("courses", {
          "course_name": course["name"],
          "teacher": course["teacher"],
          "missing": course["num_missing"],
          "graded": course["num_graded"],
          "ungraded": course["num_ungraded"],
        });
        for (var grade in course["grades"]) {
          db.insert("course_grades", {
            "course_name": course["name"],
            "category": grade["category"],
            "percent_grade": grade["percent_grade"],
            "fraction_grade": grade["fraction_grade"],
            "additional_info": grade["additional_info"]
          });
        }
        for (var assignment in course["assignments"]) {
          db.insert("assignments", {
            "course_name": course["name"],
            "name": assignment["name"],
            "date_due": assignment["date_due"],
            "score": assignment["score"],
            "impact": assignment["impact"],
            "category": assignment["category"]
          });
          return 200;
        }
      }
    } catch (e) {
      print(e);
    }
    return 1;
  }

  // save name to name.txt
  Future<String> get _namePath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _nameFile async {
    final path = await _namePath;
    File f = File('$path/name.txt');
    if (!f.existsSync()) {
      f.createSync();
    }
    return f;
  }

  Future<void> saveName(String name) async {
    File file = await _nameFile;
    // print files in current directory
    if (!file.existsSync()) {
      file.createSync();
    }

    file.writeAsStringSync(name);
  }

  Future<void> loadName() async {
    File file = await _nameFile;
    if (file.existsSync()) {
      String s = file.readAsStringSync();
      name = s;
      print("name: $name");
    } else {
      print("name not found");
    }
  }
}
