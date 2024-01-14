import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/assignment.dart';

import 'dart:convert';
import 'package:jupiter_frontend/models/assignment.dart';

class Course {
  List<Assignment> assignments;

  String name;
  String teacher;

  double ave;

  // marked as late because of compiler error
  late Map<String, double> cats;

  Course(this.name, this.teacher, this.assignments, this.ave, catMap)
      : cats = {} {
    cats = {};
    for (var cat in catMap.keys) {
      cats[cat] = double.parse(catMap[cat]);
    }
  }
  // wip
  // sort grades by category, add them up, divide by weight, return all of the categories added together
  double getGrade() {
    List<double> catGrades = [];
    for (var cat in cats.keys) {
      double catGrade = 0;
      double? catWeight = cats[cat];

      // horribly inefficient

      for (var assignment in assignments) {
        if (assignment.cat == cat) {
          catGrade += assignment.getPercent();
        }
      }
      catGrades.add(catGrade / ((catWeight ?? 100) / 6));
    }
    return catGrades.reduce((a, b) => a + b);
  }
}
