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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          assignment.name,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Center(
        child: Column(children: [
          Text(assignment.name,
              style: TextStyle(
                  fontSize: 23,
                  color: Theme.of(context).colorScheme.onBackground)),
          Text(assignment.duedate.toString(),
              style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onBackground)),
          Text(assignment.getFractionalGrade(),
              style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onBackground)),
          Text(assignment.impact.toString(),
              style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onBackground)),
          Text(assignment.cat,
              style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onBackground)),
        ]),
      ),
    ));
  }
}
