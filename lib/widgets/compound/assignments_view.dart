import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/assignment.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/widgets/info_display/assignment_tile.dart';

class AssignmentsView extends StatefulWidget {
  final Course course;
  const AssignmentsView({super.key, required this.course});

  @override
  State<AssignmentsView> createState() => _AssignmentsViewState();
}

class _AssignmentsViewState extends State<AssignmentsView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.course.assignments.map((Assignment a) {
        return AssignmentTile(assignment: a);
      }).toList(),
    );
  }
}