// this should just be a page of statistics tbh
//  ? list view or single child scroll view?

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_frontend/widgets/course.dart';

import 'package:jupiter_frontend/models/user.dart';

import 'package:jupiter_frontend/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  static List<CourseTile> courses = [];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "Loading...";

  @override
  void initState() {
    User u = User.empty();
    u.loadUserData().then((value) {
      name = u.getUsername;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(name,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
            body: ListView(
              children: [...HomePage.courses],
            )));
  }
}
