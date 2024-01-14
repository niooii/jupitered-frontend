import 'package:flutter/material.dart';

import 'package:jupiter_frontend/pages/home_page.dart';
import 'package:jupiter_frontend/pages/login_screen.dart';
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
        successCallback();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/lottiefiles/paperplane.json") ,
      ),
    );
  }
}
