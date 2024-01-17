import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/pages/home/course_tile.dart';

const List<String> sortByLabels = ["Grade (Highest)", "Grade (Lowest)", "Alphabetical"];

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});
  
  @override
  State<CoursesView> createState() => CoursesViewState();
}

class CoursesViewState extends State<CoursesView> {
  @override
  Widget build(BuildContext context) {
    List<CourseTile> courseWidgets = List.empty(growable: true);

    for(Course c in CCache().cachedCourses) {
      courseWidgets.add(CourseTile(
        course: c,
        )
      );
    }

    return Column(
      children: [
        ...courseWidgets
      ],
    );
  }
}
