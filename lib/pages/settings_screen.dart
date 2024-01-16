import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/user.dart';
import 'package:jupiter_frontend/pages/login_screen.dart';
import 'package:jupiter_frontend/pages/theme_page.dart';
import 'package:animations/animations.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/drawer.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/widgets/info_display/settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CDrawer(),
        appBar: CAppBar(title: "Settings"),
        body: Column(
          children: [
            Gap(40),
            Container(
              child: Icon(Icons.person_outline_rounded, size: 80, color: Theme.of(context).colorScheme.onBackground,),
            ),
            CallistoText(CCache().name, size: 30),
            CallistoText(User.loadUser().username, size: 30),
            const Gap(40),
            CSettingsTile("Change your theme", const Icon(Icons.palette), ThemePage()),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CSettingsTile("Log out", const Icon(Icons.keyboard_arrow_left), LoginScreen()),
              ),
            ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
