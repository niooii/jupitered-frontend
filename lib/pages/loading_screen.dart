import 'package:flutter/material.dart';

import 'package:jupiter_frontend/pages/home_page.dart';
import 'package:jupiter_frontend/pages/login_screen.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage(this.login, {super.key});
  Future login;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.primary;

    login.then((value) {
      if (value.statusCode != 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: color),
      ),
    );
  }
}
