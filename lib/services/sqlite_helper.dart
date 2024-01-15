import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:jupiter_frontend/models/assignment.dart';
import 'package:jupiter_frontend/models/course.dart';

class DBHelper {
  static DBHelper? _instance = DBHelper._();
  static late Database db;

  String name = "";

  // get instance => _instance;
  get getName {
    return name;
  }

  DBHelper._() {
    _instance = this;
    initDB()
        .whenComplete(() => print("DATAABASE HAS BEEN INTIAILIZED!!@! ! !! "));
  }

  static DBHelper getInstance() {
    return _instance!;
  }

  Future<void> initDB() async {
    // clearDB();

    _instance?.loadName();

    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'users_demo.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE courses (
              course_name TEXT NOT NULL,
              teacher TEXT NOT NULL,
              missing INTEGER NOT NULL,
              graded INTEGER NOT NULL,
              ungraded INTEGER NOT NULL,
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
    // print("courseMapList");
    for (var course in courseMapList) {
      // print(course);
    }
    // print("courseMap");
    for (var course in courseMap.entries) {
      // print(course);
    }

    for (var course in courseMapList) {
      List<Assignment> assingments =
          await getAssignments(course["course_name"]);
      List<Map<String, dynamic>> catMap = await db.query("course_grades",
          where: "course_name = ?", whereArgs: [course["course_name"]]);
      // print(catMap[0]);

      courses.add(Course(course["course_name"], course["teacher"], assingments,
          catMap[0]["percent_grade"], catMap));
    }
    return courses;
  }

  Future<List<Assignment>> getAssignments(String course) async {
    List<Assignment> assignments = [];
    List<Map<String, dynamic>> assignmentMap = await db
        .rawQuery('SELECT * FROM assignments WHERE course_name = ?', [course]);

    for (var assignment in assignmentMap) {
      assignments.add(Assignment.fromMap(assignment));
    }
    return assignments;
  }

  Future<int> storeApiResponse(String json) async {
    try {
      var data = JsonDecoder().convert(json);
      // print("data: ${data["courses"][1]}");
      // print("storeApiResponse: ${data["courses"]}");
      name = data["name"];
      // print(data["courses"].length);
      for (int i = 0; i < data["courses"].length; i++) {
        // print("course: ${data["courses"][i]}");
        await db.query("courses",
            where: "course_name = ?",
            whereArgs: [data["courses"][i]["name"]]).then((val) {
          if (val.isEmpty) {
            db.insert("courses", {
              "course_name": data["courses"][i]["name"],
              "teacher": data["courses"][i]["teacher_name"],
              "missing": data["courses"][i]["num_missing"],
              "graded": data["courses"][i]["num_graded"],
              "ungraded": data["courses"][i]["num_ungraded"],
              "total": data["courses"][i]["num_total"]
            });
          } else {
            db.update("courses", {
              "course_name": data["courses"][i]["name"],
              "teacher": data["courses"][i]["teacher_name"],
              "missing": data["courses"][i]["num_missing"],
              "graded": data["courses"][i]["num_graded"],
              "ungraded": data["courses"][i]["num_ungraded"],
              "total": data["courses"][i]["num_total"]
            });
          }
        });
        for (var grade in data["courses"][i]["grades"]) {
          await db.query("course_grades",
              where: "course_name = ? AND category = ?",
              whereArgs: [
                data["courses"][i]["name"],
                grade["category"]
              ]).then((val) {
            if (val.isEmpty) {
              db.insert("course_grades", {
                "course_name": data["courses"][i]["name"],
                "category": grade["category"],
                "percent_grade": grade["percent_grade"],
                "fraction_grade": grade["fraction_grade"],
                "additional_info": grade["additional_info"]
              });
            } else {
              db.update("course_grades", {
                "course_name": data["courses"][i]["name"],
                "category": grade["category"],
                "percent_grade": grade["percent_grade"],
                "fraction_grade": grade["fraction_grade"],
                "additional_info": grade["additional_info"]
              });
            }
          });
        }

        for (var assignment in data["courses"][i]["assignments"]) {
          await db.query("assignments",
              where: "course_name = ? AND name = ?",
              whereArgs: [
                data["courses"][i]["name"],
                assignment["name"]
              ]).then((val) {
            if (val.isEmpty) {
              db.insert("assignments", {
                "course_name": data["courses"][i]["name"],
                "name": assignment["name"],
                "date_due": assignment["date_due"],
                "score": assignment["score"],
                "impact": assignment["impact"],
                "category": assignment["category"]
              });
            } else {
              db.update("assignments", {
                "course_name": data["courses"][i]["name"],
                "name": assignment["name"],
                "date_due": assignment["date_due"],
                "score": assignment["score"],
                "impact": assignment["impact"],
                "category": assignment["category"]
              });
            }
          });
        }
      }
      print("help");
    } catch (e) {
      print(e);
      return 0;
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

  // test schema for courses

  Future<void> clearDB() async {
    deleteDatabase(db.path);
  }
}
