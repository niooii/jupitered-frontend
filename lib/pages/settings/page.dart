import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/pages/settings/preferences/page.dart';
import 'package:jupiter_frontend/pages/settings/themes/page.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/pages/settings/setting_tile.dart';

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
        // drawer: CDrawer(),
        appBar: const CAppBar(title: "Settings"),
        body: Column(
          children: [
            const Gap(40),
            Icon(Icons.person_outline_rounded, size: 100, color: Theme.of(context).colorScheme.onBackground,),
            CallistoText(CCache().name, size: 30),
            CallistoText(CCache().osis, size: 20),
            const Gap(40),
            CSettingsTile("Preferences", const Icon(Icons.settings_outlined), const PreferencesPage()),
            const Gap(10),
            CSettingsTile("Theme", const Icon(Icons.palette), const ThemePage()),
            // const Gap(10),
            // CSettingsTile("Manage Notifications", const Icon(CupertinoIcons.bubble_left), const ThemePage()),
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
