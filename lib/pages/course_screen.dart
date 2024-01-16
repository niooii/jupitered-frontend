import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/widgets/compound/assignments_view.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';

class CourseScreen extends StatelessWidget {
  final Course course;
  const CourseScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(title: course.name),
      body: AssignmentsView(course: course),
    );
  }
}