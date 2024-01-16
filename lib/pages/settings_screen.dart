import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/user.dart';
import 'package:jupiter_frontend/pages/login_screen.dart';
import 'package:jupiter_frontend/pages/theme_page.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/drawer.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/widgets/info_display/setting_tile.dart';

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
            const Gap(40),
            Icon(Icons.person_outline_rounded, size: 100, color: Theme.of(context).colorScheme.onBackground,),
            CallistoText(CCache().name, size: 30),
            CallistoText(CCache().osis, size: 20),
            const Gap(40),
            CSettingsTile("Preferences", const Icon(Icons.settings_outlined), ThemePage()),
            const Gap(10),
            CSettingsTile("Theme", const Icon(Icons.palette), const ThemePage()),
            // Expanded(
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: CSettingsTile("Log out", const Icon(Icons.keyboard_arrow_left), LoginScreen()),
            //   ),
            // ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
