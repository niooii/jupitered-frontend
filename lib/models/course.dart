import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/assignment.dart';

import 'dart:convert';

import 'package:jupiter_frontend/models/assigbment.dart';

class Course {
  List<Assignment> assignments;

  String name;
  String teacher;

  Map<String, double> cats;

  Course(this.name, this.teacher, this.assignments, catMap)
      : cats = JsonDecoder().convert(catMap);
}