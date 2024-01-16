//  ? list view or single child scroll view?

import 'package:flutter/material.dart';
import 'package:jupiter_frontend/services/sqlite_helper.dart';
import 'package:jupiter_frontend/widgets/callisto_app_bar.dart';
import 'package:jupiter_frontend/widgets/course.dart';

class CoursePage extends StatefulWidget {
  CoursePage({super.key});

  List<CourseTile> courses = [];

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String name = "Loading...";

  @override
  void initState() {
    name = DBHelper.getInstance().getName;
    DBHelper.getInstance().getCourses().then((value) => {
          widget.courses = value.map((e) => CourseTile(e)).toList(),
          setState(() {})
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CallistoAppBar(title: "Courses"),
        body: ListView(children: widget.courses)
      )
    );
  }
}
