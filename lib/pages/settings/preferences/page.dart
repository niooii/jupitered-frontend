import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_frontend/services/shared_preferences.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(title: "Preferences"),
      body: ListView(
        children: [
          Checkbox(value: CSharedPrefs().autoLogIn, onChanged: (val) {
            CSharedPrefs().autoLogIn = val!;
          })
        ],
      ),
    );
  }
}