import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/pages/home_page.dart';
import 'package:jupiter_frontend/widgets/course.dart';

import 'package:jupiter_frontend/pages/theme_page.dart';

class AppDrawer extends StatelessWidget {
  static List<CourseTile> courses = [];
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
            child: const Text('Calisto')),
        const Gap(gap),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThemePage()),
            );
          },
        )
      ],
    ));
  }
}
