import 'package:flutter/material.dart';

import 'package:jupiter_frontend/pages/login_screen.dart';
import 'package:jupiter_frontend/pages/home/page.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage(this.login, this.errorCallback, this.successCallback, {super.key});
  Future login;
  Function errorCallback;
  Function successCallback;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.primary;

    Future<void> handleLogin() async {
      final value = await login;
      if (value.statusCode != 200) {
        errorCallback(value.body);
        Navigator.pop(context);
      } else {
        await successCallback(); // Wait for successCallback to complete

        // grab the data and put it into global cache
        final courseList = await CDbManager.getInstance().getCourses();
        CCache().cacheCourses(courseList);

        // main screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }

    handleLogin();

    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/lottiefiles/paperplane.json"),
      ),
    );
  }
}
