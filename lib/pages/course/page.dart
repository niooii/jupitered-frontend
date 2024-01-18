import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/pages/all_assignments/assignments_view.dart';
import 'package:jupiter_frontend/pages/course/DEPRECATED.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';
import 'package:jupiter_frontend/widgets/general/divider.dart';

class CoursePage extends StatelessWidget {
  final Course course;
  const CoursePage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(title: course.name),
      body: ListView(
        children: [
          // TODO!
          // display grade category info here
          ...course.gradeCategories.map<Widget>((category) {
            return Text(category.toString());
          }),
          CDivider(),
          AssignmentsView(assignments: course.assignments)
        ],
      ),
    );
  }
}