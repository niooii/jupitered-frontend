import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/pages/all_assignments/page.dart';
import 'package:jupiter_frontend/pages/course/page.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/pages/login/page.dart';
import 'package:jupiter_frontend/pages/home/page.dart';
import 'package:jupiter_frontend/pages/settings/page.dart';
import 'package:jupiter_frontend/services/shared_preferences.dart';
import 'package:jupiter_frontend/widgets/general/divider.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/drawer_tile.dart';

class CDrawer extends StatelessWidget {
  static const double gap = 5;

  const CDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> courseTiles = List.empty(growable: true);
    // maybe NOT run this loop every fucking time we open the drawer.
    for (Course c in CCache().cachedCourses) {
      courseTiles.add(Column(
        children: [
          CDrawerTile(
            isCorePage: false,
            icon: const Icon(CupertinoIcons.chevron_forward ),
            splashColor: Theme.of(context).colorScheme.surface,
            redirectPage: CoursePage(course: c),
            text: c.name),
          const Gap(gap),
        ],
      ));
    }

    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
                child: Image.asset(
              'assets/images/jupiter-transparent.png',
              height: 200,
            )),
          ),
          const CDivider(),
          const Gap(gap),
          CDrawerTile(
              icon: const Icon(CupertinoIcons.home),
              splashColor: Theme.of(context).colorScheme.surface,
              redirectPage: HomePage(),
              text: "Home"),
          const Gap(gap),
          CDrawerTile(
              icon: const Icon(CupertinoIcons.doc_text),
              splashColor: Theme.of(context).colorScheme.surface,
              redirectPage:
                  AllAssignmentsPage(allCourses: CCache().cachedCourses),
              text: "All Assignments"),
          const CDivider(),
          // GENERATED COURSE TILES DYNAMICALLY
          ...courseTiles,
          const CDivider(),
          CDrawerTile(
            icon: const Icon(Icons.settings_outlined),
            splashColor: Theme.of(context).colorScheme.surface,
            redirectPage: const SettingsPage(),
            text: "Settings",
            isCorePage: false,
          ),
          CDrawerTile(
            icon: const Icon(CupertinoIcons.square_arrow_left),
            splashColor: Theme.of(context).colorScheme.error,
            hoverColor: Theme.of(context).colorScheme.error,
            redirectPage: LoginPage(),
            text: "Logout",
            onTapCallback: () {
              CSharedPrefs().autoLogIn = false;
              CSharedPrefs().save();
            },
          ),
        ],
      ),
    );
  }
}
