import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/services/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:jupiter_frontend/models/assignment.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class CDbManager {
  static CDbManager? _instance = CDbManager._();
  static late Database db;

  CDbManager._() {
    _instance = this;
    initDB().whenComplete(() => print("DATABASE HAS BEEN INITIALIZED!!"));
  }

  static CDbManager getInstance() {
    return _instance!;
  }

  Future<void> initDB() async {
    // _instance?.loadName();

    // sqfliteFfiInit();

    // databaseFactory = databaseFactoryFfi;
  

    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'callisto.db'),
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
              status TEXT NOT NULL,
              worth INTEGER NOT NULL,
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
      await db.query("course_grades",
          where: "course_name = ?",
          whereArgs: [course["course_name"]]).then((catMapList) {
        courses.add(Course(
            course["course_name"],
            course["teacher"],
            course["place_and_time"],
            course["missing"],
            course["ungraded"],
            course["graded"],
            course["total"],
            assignments,
            double.tryParse(catMapList[0]["percent_grade"].toString()) ?? 0,
            catMapList.map((categoryMap) {
              /* 
            {
              "category": "Course Average",
              "percent_grade": 97.1,
              "fraction_grade": null,
              "additional_info": null
            },
            */
            // print(categoryMap["fraction_grade"]);
              return GradeCategory(
                  category: categoryMap["category"]!.toString(),
                  percentGrade: double.tryParse(
                          categoryMap["percent_grade"].toString()),
                  fractionGrade: categoryMap["fraction_grade"]?.toString(),
                  additionalInfo: categoryMap["additional_info"]?.toString());
            }).toList()));
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

      // what am i even doing here
      // CCache().cacheName(data["name"]);
      // CCache().cacheOsis(data["osis"]);
      // ! if name is different than the person that previously logged in,
      // clear db
      if(CSharedPrefs().name != data["name"]) {
        await db.transaction((txn) async {
          txn.delete("courses", where: null);
          txn.delete("course_grades", where: null);
          txn.delete("assignments", where: null);
        });
      }
      CSharedPrefs().name = data["name"];
      // domain expansion: infinite i/o operations
      CSharedPrefs().save();

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
                "status": assignment["status"],
                "worth": assignment["worth"],
                "impact": assignment["impact"],
                "category": assignment["category"],
              });
            } else {
              // await txn.delete(
              //   "assignments",
              //   where: null
              // );
              await txn.update(
                "assignments",
                {
                  "course_name": course["name"],
                  "name": assignment["name"],
                  "date_due": assignment["date_due"],
                  "score": assignment["score"],
                  "status": assignment["status"],
                  "worth": assignment["worth"],
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
      print("Exception: $e");
      return 0;
    }
    return 1;
  }

  Future<String> get _namePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Future<void> loadName() async {
  //   File file = await _nameFile;
  //   if (file.existsSync()) {
  //     String s = file.readAsStringSync();
  //     name = s;
  //   }
  // }

  Future<void> clearDB() async {
    deleteDatabase(db.path);
  }
}
