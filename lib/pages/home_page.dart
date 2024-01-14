// this should just be a page of statistics tbh
//  ? list view or single child scroll view?

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_frontend/widgets/course.dart';

import 'package:jupiter_frontend/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static List<CourseTile> courses = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text('Home',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
            body: ListView(
              children: [...courses],
            )));
  }
}
