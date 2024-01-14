import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/pages/home_page.dart';
import 'package:jupiter_frontend/pages/login_screen.dart';
import 'package:jupiter_frontend/widgets/course.dart';

import 'package:jupiter_frontend/pages/theme_page.dart';

// TODO!
class CallistoListTile extends StatelessWidget {
  const CallistoListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AppDrawer extends StatelessWidget {
  static List<CourseTile> courses = [];

  static setCourses(List<CourseTile> cts) {
    courses = cts;
  }

  static const double gap = 5;

  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Callisto',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              )),
          const Gap(gap),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          const Gap(gap),
          ...courses,
          const Gap(gap),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Theme'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ThemePage()),
              );
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                splashColor: Theme.of(context).colorScheme.error,
                leading: const Icon(Icons.keyboard_arrow_left),
                title: const Text('Log out'),
                onTap: () {
                  // TODO! handle some other logic here regarding user and remember me.
                  // EG: when user clicks logout, remember me should be unchecked.
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return LoginScreen();
                  }), (r) {
                    return false;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
