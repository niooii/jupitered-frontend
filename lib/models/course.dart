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

  double ave;

  // marked as late because of compiler error
  List<Map<String, dynamic>> cats;

  Course(this.name, this.teacher, this.placeAndTime, this.missingAssignments, this.ungradedAssignments, this.gradedAssignments, this.totalAssignments, this.assignments, this.ave, this.cats);
}

