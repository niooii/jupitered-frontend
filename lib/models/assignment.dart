import 'package:flutter/material.dart';

enum AssignmentStatus {
  graded,
  ungraded,
  missing,
  thiswillneverhappenbutitsfine
}

class Assignment {
  String name;
  String courseName;
  DateTime? duedate;
  AssignmentStatus status;

  String score;
  double percentScore;

  String impact;

  String cat;
  int weight;

  Assignment(this.name, this.duedate, this.score, this.status, this.percentScore, this.impact,
      this.cat, this.weight, this.courseName);

  factory Assignment.fromMap(Map<String, dynamic> map) {
    AssignmentStatus status = parseStatus(map["status"]);
    return Assignment(
        map["name"],
        parseDate(map["date_due"]),
        map["score"],
        status,
        parseScore(status, map["score"]),
        map["impact"],
        map["category"],
        // its called worth from jupiter but weiht makes more sense L OLOL
        map["worth"],
        map["course_name"]);
  }
  // {
  // 	"name": "Midyear Project (Source Code and Video)",
  // 	"date_due": "1/7",
  // 	"score": "/100",
  // 	"worth": 100,
  // 	"impact": "",
  // 	"category": "Midyear/Final"
  // },
  // static double parseMaxScore(String score) {
  //   if (score == "absent") {
  //     return 0;
  //   }
  //   if (score == "absent") {
  //     return 0;
  //   }
  //   if (score == "zero") {
  //     return 0;
  //   }
  //   var split = score.split("/");
  //   print(split[split.length == 1 ? 0 : 1]);
  //   return double.parse(split[split.length == 1 ? 0 : 1]);
  // }

  static double parseScore(AssignmentStatus status, String score) {
    if(status == AssignmentStatus.ungraded || status == AssignmentStatus.missing) {
      return 0;
    }

    // status is handled by api call already, this should never fail. 
    var splitString = score.split("/");

    // if(splitString.length != 2) {
      
    // }

    double dividend = double.parse(splitString[0]);
    double divisor = double.parse(splitString[1]);

    return (dividend/divisor) * 100;
  }

  static AssignmentStatus parseStatus(String status) {
    switch(status) {
      case "GRADED":
        return AssignmentStatus.graded;
      case "UNGRADED":
        return AssignmentStatus.ungraded;
      case "MISSING":
        return AssignmentStatus.missing;
      default:
        return AssignmentStatus.thiswillneverhappenbutitsfine;
    }
  }

  static DateTime? parseDate(String dd) {
    if(dd.isEmpty) {
      return null;
    }

    int month = int.parse(dd.split("/")[0]);
    int day = int.parse(dd.split("/")[1]);

    late int year; 
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;
    if (month >= 9) {
      if (currentMonth < 9) {
        year = currentYear - 1;
      } else {
        year = currentYear;
      }
    } else {
      year = currentYear;
    }

    return DateTime(year, month, day);
  }

  // double getPercent() {
  //   // print(
  //   // "grade: $grade, maxGrade: $maxGrade = ${((grade ?? 0) / maxGrade) * 100}");
  //   return ((grade ?? 0) / maxGrade) * 100;
  // }

  // String getFractionalGrade() {
  //   return grade.toString() + "/" + maxGrade.toString();
  // }

  // double getWeightedGrade() {
  //   return (grade ?? 0) * weight;
  // }
}
