import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:jupiter_frontend/models/assignment.dart';

class AssignmentTile extends StatelessWidget {
  const AssignmentTile({Key? key, required this.assignment}) : super(key: key);

  final Assignment assignment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(assignment.name),
      subtitle: Text(assignment.duedate.toString()),
      trailing: Text(assignment.getPercent().toString() + "%"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AssignmentDetails(assignment: assignment)),
        );
      },
    );
  }
}

class AssignmentDetails extends StatelessWidget {
  const AssignmentDetails({Key? key, required this.assignment})
      : super(key: key);

  final Assignment assignment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(assignment.name),
      ),
      body: Column(
        children: [
          Text(assignment.name),
          Text(assignment.duedate.toString()),
          Text(assignment.getFractionalGrade()),
          Text(assignment.impact.toString()),
          Text(assignment.cat),
        ],
      ),
    );
  }
}