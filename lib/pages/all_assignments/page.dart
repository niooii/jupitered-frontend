import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/assignment.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';

class AllAssignmentsPage extends StatefulWidget {
  List<Course> allCourses;
  late List<Assignment> allAssignments = List.empty(growable: true);
  late List<Assignment> toRender = List.empty(growable: true);
  AllAssignmentsPage({super.key, required this.allCourses}) {
    for (Course c in allCourses) {
      allAssignments.addAll(c.assignments);
    }
    toRender.addAll(allAssignments);

    print(allAssignments);
  }

  @override
  State<AllAssignmentsPage> createState() => _AllAssignmentsPageState();
}

class _AllAssignmentsPageState extends State<AllAssignmentsPage> {
  List<Assignment> toRender = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(title: "Assignments"),
      body: ListView(),
    );
  }
}
