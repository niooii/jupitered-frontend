import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/assignment.dart';
import 'package:jupiter_frontend/pages/error/page.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';

// TODO! REFACTOR 
class AssignmentTile extends StatelessWidget {
  bool includeCourseName;
  AssignmentTile({Key? key, required this.assignment, this.includeCourseName = false}) : super(key: key);

  final Assignment assignment;

  @override
  Widget build(BuildContext context) {
    late Widget trailingWidget;

    switch(assignment.status) {
      
      case AssignmentStatus.graded:
        trailingWidget = CallistoText("${assignment.percentScore.toStringAsFixed(2)}%", size: 17);
        break;
      case AssignmentStatus.ungraded:
        trailingWidget = const CallistoText("Ungraded", size: 17);
        break;
      case AssignmentStatus.missing:
        trailingWidget = CallistoText("Missing", size: 17, color: Theme.of(context).colorScheme.error);
      default:
        Navigator.push(context, MaterialPageRoute(builder: (builder) {
          return const ErrorPage();
        }));
    }

    return ExpansionTile(
      title: CallistoText(assignment.name, size: 15),
      subtitle: Text(includeCourseName ? "${assignment.courseName} - ${assignment.duedate.toString()}" : assignment.duedate.toString()),
      trailing: trailingWidget,
      children: [
        CallistoText(assignment.score, size: 17),
        CallistoText("Impact: ${assignment.impact}", size: 17),
        CallistoText("Weight: ${assignment.weight}", size: 17)
      ],
    );
  }
}
