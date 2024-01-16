import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/pages/home_page.dart';
import 'package:jupiter_frontend/pages/login_screen.dart';
import 'package:jupiter_frontend/pages/main_screen.dart';
import 'package:jupiter_frontend/pages/settings_page.dart';
import 'package:jupiter_frontend/widgets/callisto_drawer_option.dart';
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

class CallistoDrawer extends StatelessWidget {
  static List<CourseTile> courses = [];

  static setCourses(List<CourseTile> cts) {
    courses = cts;
  }

  static const double gap = 5;

  const CallistoDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Image.asset('assets/images/jupiter-transparent.png', height: 200,)
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Theme.of(context).colorScheme.onBackground
          ),
          const Gap(gap),
          ...courses,
          const Gap(gap),
          CallistoDrawerOption(
            icon: const Icon(CupertinoIcons.home), 
            splashColor: Theme.of(context).colorScheme.surface, 
            redirectPage: MainScreen(), 
            text: "Home"
          ),
          const Gap(gap),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Divider(
                    thickness: 0.5,
                    color: Theme.of(context).colorScheme.onBackground
                  ),
                  CallistoDrawerOption(
                    icon: const Icon(Icons.settings_outlined),
                    splashColor: Theme.of(context).colorScheme.surface,
                    redirectPage: const SettingsPage(),
                    text: "Settings",
                  ),
                  CallistoDrawerOption(
                    icon: const Icon(Icons.keyboard_arrow_left),
                    splashColor: Theme.of(context).colorScheme.error,
                    hoverColor: Theme.of(context).colorScheme.error,
                    redirectPage: LoginScreen(),
                    text: "Logout",
                  ),
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}


