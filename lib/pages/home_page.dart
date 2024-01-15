// this should just be a page of statistics tbh
//  ? list view or single child scroll view?

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/services/sqlite_helper.dart';
import 'package:jupiter_frontend/widgets/course.dart';

import 'package:jupiter_frontend/models/user.dart';

import 'package:jupiter_frontend/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  List<CourseTile> courses = [];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "Loading...";

  @override
  void initState() {
    name = DBHelper.getInstance().getName;
    DBHelper.getInstance().getCourses().then((value) => {
          widget.courses = value.map((e) => CourseTile(e)).toList(),
          AppDrawer.courses = value.map((e) => CourseTile(e)).toList(),
          setState(() {})
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      // CourseTile(Course("Loading...", "Loading...", [], 0.0, [{}]))
    ];
    if (widget.courses.isNotEmpty) {
      widgets.addAll(widget.courses);
    }
    for (CourseTile course in widget.courses) {
      print(course.course.name);
    }

    return SafeArea(
        child: Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(name,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
            body: ListView(children: widgets)));
  }
}
