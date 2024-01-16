import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/pages/login_screen.dart';
import 'package:jupiter_frontend/pages/theme_page.dart';
import 'package:animations/animations.dart';
import 'package:jupiter_frontend/widgets/callisto_app_bar.dart';
import 'package:jupiter_frontend/widgets/callisto_drawer.dart';
import 'package:jupiter_frontend/widgets/settings_option.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CallistoDrawer(),
        appBar: CallistoAppBar(title: "Settings"),
        body: Column(
          children: [
            Gap(40),
            Container(
              child: Icon(Icons.person_outline_rounded, size: 80, color: Theme.of(context).colorScheme.onBackground,),
              // decoration: BoxDecoration(
              //   color: Theme.of(context).colorScheme.primary,
              // ),
              // width: double.infinity,
              // height: 150,
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Settings',
              //       style: TextStyle(
              //         color: Theme.of(context).colorScheme.onPrimary,
              //         fontSize: 24,
              //         fontWeight: FontWeight.bold,
              //       ),
              //       textAlign: TextAlign.center,
              //     )
              //   ],
              // ),
            ),
            const Gap(40),
            SettingsOption("Change your theme", const Icon(Icons.palette), ThemePage()),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SettingsOption("Log out", const Icon(Icons.keyboard_arrow_left), LoginScreen()),
              ),
            ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
