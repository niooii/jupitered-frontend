import 'package:flutter/material.dart';
import 'package:jupiter_frontend/pages/login_screen.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';

import 'package:jupiter_frontend/pages/theme_page.dart';

// test import

class JupiterFrontendApp extends StatefulWidget {
  const JupiterFrontendApp({super.key});

  @override
  State<JupiterFrontendApp> createState() => _JupiterFrontendAppState();

  static getState() {
    return _JupiterFrontendAppState.instance;
  }
}

class _JupiterFrontendAppState extends State<JupiterFrontendApp> {
  static late _JupiterFrontendAppState instance;

  ThemeData _theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  static void setAppTheme(ThemeData theme) {
    instance.setTheme(theme);
  }

  void setTheme(ThemeData theme) {
    setState(() {
      _theme = theme;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _theme,
      home: ThemePage(),
      //     LoginScreen(
      //   key: key,
      // ),
    );
  }
}
