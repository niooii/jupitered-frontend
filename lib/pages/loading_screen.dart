import 'package:flutter/material.dart';

import 'package:jupiter_frontend/pages/courses_page.dart';
import 'package:jupiter_frontend/pages/login_screen.dart';
import 'package:jupiter_frontend/pages/main_screen.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/services/sqlite_helper.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage(this.login, this.errorCallback, this.successCallback, {super.key});
  Future login;
  Function errorCallback;
  Function successCallback;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.primary;

    login.then((value) {
      if (value.statusCode != 200) {
        errorCallback(value.body);
        Navigator.pop(context);
      } else {
        successCallback().whenComplete(() {
          // grab the data and put it into global cache
          DBHelper.getInstance().getCourses().then((courseList) => {
            CallistoCache().cacheCourses(courseList)
          });
          // caching OSIS and NAME are handled in DBHELPER::storeAPIRespones
          // main screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        });
      }
    });

    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/lottiefiles/paperplane.json"),
      ),
    );
  }
}
