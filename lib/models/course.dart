import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/assignment.dart';

import 'dart:convert';

// !!!! https://docs.flutter.dev/data-and-backend/serialization/json#code-generation docs
class Course {
  List<Assignment> assignments;

  String name;
  String teacher;
  String placeAndTime;
  int missingAssignments;
  int ungradedAssignments;
  int gradedAssignments;
  int totalAssignments;
  // TODO! this will break at the beginning of the year LOLOLO
  // may have to update backend too.
  double average;

  // marked as late because of compiler error
  List<GradeCategory> gradeCategories;

  Course(this.name, this.teacher, this.placeAndTime, this.missingAssignments, this.ungradedAssignments, this.gradedAssignments, this.totalAssignments, this.assignments, this.average, this.gradeCategories);
}
/* 
CREATE TABLE course_grades (
  course_name TEXT NOT NULL,
  category TEXT NOT NULL,
  percent_grade REAL,
  fraction_grade TEXT,
  additional_info TEXT
);
*/
class GradeCategory {
  String category;
  double? percentGrade;
  String? fractionGrade;
  String? additionalInfo;

  GradeCategory({required this.category, this.percentGrade, this.fractionGrade, this.additionalInfo});
}
