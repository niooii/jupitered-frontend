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
  List<Map<String, dynamic>> cats;

  Course(this.name, this.teacher, this.assignments, this.ave, this.cats);
}


  // wip

