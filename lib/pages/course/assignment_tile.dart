import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/assignment.dart';

class AssignmentTile extends StatelessWidget {
  const AssignmentTile({Key? key, required this.assignment}) : super(key: key);

  final Assignment assignment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(assignment.name),
      subtitle: Text(assignment.duedate.toString()),
      trailing: Text(assignment.score),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssignmentDetails(assignment: assignment),
          ),
        );
      },
    );
  }
}

class AssignmentDetails extends StatelessWidget {
  const AssignmentDetails({Key? key, required this.assignment})
      : super(key: key);

  final Assignment assignment;

// TODO! make expandable
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
          child: Column(
            children: [
              _buildTextWidget(context, assignment.name, 23),
              _buildTextWidget(context, assignment.duedate.toString(), 20),
              _buildTextWidget(context, assignment.score, 20),
              _buildTextWidget(context, assignment.impact.toString(), 20),
              _buildTextWidget(context, assignment.cat, 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextWidget(BuildContext context, String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
