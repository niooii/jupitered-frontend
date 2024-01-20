import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jupiter_frontend/pages/loading_screen.dart';

import 'package:jupiter_frontend/pages/login/page.dart';

import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:jupiter_frontend/pages/home/page.dart';
import 'package:jupiter_frontend/pages/settings/themes/page.dart';
import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:jupiter_frontend/services/shared_preferences.dart';

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
  
  Future<bool> connectedToInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        // right?? righit??? right ??????
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // Widget target = LoginScreen();

    // if(CSharedPrefs().autoLogIn) {
    //   connectedToInternet().then((connected) {
    //     if(!connected) {

    //     }
    //   });
    // }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Callisto',
      theme: _theme,

      // if auto login from shared preferences (changable in settings) is true, go to main screen directly. if CCache().loadCacheFromDisk returns false,
      // main screen = home page no?
      // fetch data. if it cant fetch data (no internet or api down), redirect user to an error screen and explain.
      home: CSharedPrefs().autoLogIn ? HomePage() : LoginPage(),
      //     LoginScreen(
      //   key: key,
      // ),
    );
  }
}
