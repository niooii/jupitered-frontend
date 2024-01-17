import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:jupiter_frontend/models/assignment.dart';
import 'package:jupiter_frontend/models/course.dart';

class DBHelper {
  static DBHelper? _instance = DBHelper._();
  static late Database db;

  String name = "";

  DBHelper._() {
    _instance = this;
    initDB().whenComplete(() => print("DATABASE HAS BEEN INITIALIZED!!"));
  }

  static DBHelper getInstance() {
    return _instance!;
  }

  get getName {
    return name;
  }

  Future<void> initDB() async {
    _instance?.loadName();

    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'calisto.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE courses (
              course_name TEXT NOT NULL,
              teacher TEXT NOT NULL,
              place_and_time TEXT NOT NULL,
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

    if (courseMapList.isEmpty) {
      return courses;
    }

    for (int i = 0; i < courseMapList.length; i++) {
      var course = courseMapList[i];
      List<Assignment> assignments =
          await getAssignments(course["course_name"]);
      print(course);
      await db.query("course_grades",
          where: "course_name = ?",
          whereArgs: [course["course_name"]]).then((catMap) {
        courses.add(Course(
          course["course_name"],
          course["teacher"],
          course["place_and_time"],
          course["missing"],
          course["ungraded"],
          course["graded"],
          course["total"],
          assignments,
          double.tryParse(catMap[0]["percent_grade"].toString()) ?? 0,
          catMap,
        ));
      });
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
      name = data["name"];

      await db.transaction((txn) async {
        for (int i = 0; i < data["courses"].length; i++) {
          var course = data["courses"][i];
          var existingCourses = await txn.query("courses",
              where: "course_name = ?", whereArgs: [course["name"]]);

          if (existingCourses.isEmpty) {
            await txn.insert("courses", {
              "course_name": course["name"],
              "teacher": course["teacher_name"],
              "place_and_time": course["place_and_time"],
              "missing": course["num_missing"],
              "graded": course["num_graded"],
              "ungraded": course["num_ungraded"],
              "total": course["num_total"],
            });
          } else {
            await txn.update(
              "courses",
              {
                "course_name": course["name"],
                "teacher": course["teacher_name"],
                "place_and_time": course["place_and_time"],
                "missing": course["num_missing"],
                "graded": course["num_graded"],
                "ungraded": course["num_ungraded"],
                "total": course["num_total"],
              },
              where: "course_name = ?",
              whereArgs: [course["name"]],
            );
          }

          for (var category in course["grades"]) {
            var existingCategories = await txn.query("course_grades",
                where: "course_name = ? AND category = ?",
                whereArgs: [course["name"], category["category"]]);

            if (existingCategories.isEmpty) {
              await txn.insert("course_grades", {
                "course_name": course["name"],
                "category": category["category"],
                "percent_grade": category["percent_grade"],
                "fraction_grade": category["fraction_grade"],
                "additional_info": category["additional_info"],
              });
            } else {
              await txn.update(
                "course_grades",
                {
                  "course_name": course["name"],
                  "category": category["category"],
                  "percent_grade": category["percent_grade"],
                  "fraction_grade": category["fraction_grade"],
                  "additional_info": category["additional_info"],
                },
                where: "course_name = ? AND category = ?",
                whereArgs: [course["name"], category["category"]],
              );
            }
          }

          for (var assignment in course["assignments"]) {
            var existingAssignments = await txn.query("assignments",
                where: "course_name = ? AND name = ?",
                whereArgs: [course["name"], assignment["name"]]);

            if (existingAssignments.isEmpty) {
              await txn.insert("assignments", {
                "course_name": course["name"],
                "name": assignment["name"],
                "date_due": assignment["date_due"],
                "score": assignment["score"],
                "impact": assignment["impact"],
                "category": assignment["category"],
              });
            } else {
              await txn.update(
                "assignments",
                {
                  "course_name": course["name"],
                  "name": assignment["name"],
                  "date_due": assignment["date_due"],
                  "score": assignment["score"],
                  "impact": assignment["impact"],
                  "category": assignment["category"],
                },
                where: "course_name = ? AND name = ?",
                whereArgs: [course["name"], assignment["name"]],
              );
            }
          }
        }
      });
    } catch (e) {
      print(e);
      return 0;
    }
    return 1;
  }

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
    }
  }

  Future<void> clearDB() async {
    deleteDatabase(db.path);
  }
}
