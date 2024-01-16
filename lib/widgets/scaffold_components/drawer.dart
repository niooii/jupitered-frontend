import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/widgets/compound/stats_view.dart';
import 'package:jupiter_frontend/pages/login_screen.dart';
import 'package:jupiter_frontend/pages/main_screen.dart';
import 'package:jupiter_frontend/pages/settings_screen.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/drawer_divider.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/drawer_tile.dart';

import 'package:jupiter_frontend/pages/theme_page.dart';

class CDrawer extends StatelessWidget {

  static const double gap = 5;

  const CDrawer({super.key});

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
          const CDrawerDivider(),
          // const Gap(gap),
          // ...courses,
          const Gap(gap),
          CDrawerTile(
            icon: const Icon(CupertinoIcons.home), 
            splashColor: Theme.of(context).colorScheme.surface, 
            redirectPage: MainScreen(), 
            text: "Home"
          ),
          const Gap(gap),
          CDrawerTile(
            icon: const Icon(CupertinoIcons.bubble_left), 
            splashColor: Theme.of(context).colorScheme.surface, 
            redirectPage: MainScreen(), 
            text: "Manage notifications"
          ),
          const Gap(gap),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CDrawerDivider(),
                  CDrawerTile(
                    icon: const Icon(Icons.settings_outlined),
                    splashColor: Theme.of(context).colorScheme.surface,
                    redirectPage: const SettingsScreen(),
                    text: "Settings",
                  ),
                  CDrawerTile(
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


