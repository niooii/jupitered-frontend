import 'package:flutter/material.dart';

import 'package:jupiter_frontend/pages/login/page.dart';
import 'package:jupiter_frontend/pages/home/page.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage(this.login, this.exceptionCallback, this.errorCallback,
      this.successCallback,
      {super.key});
  Future login;
  Function exceptionCallback;
  Function errorCallback;
  Function successCallback;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  String loadingMessage = "Logging in...";

  @override
  void initState() {
    super.initState();
    handleLogin();
  }

  Future<void> handleLogin() async {
    try {
      final value = await widget.login;
      if (value.statusCode != 200) {
        widget.errorCallback(value.body);
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        setState(() {
          loadingMessage = "Fetching data...";
        });

        await widget.successCallback(); // wait for successCallback to complete

        // grab the data and shove it into global cache
        final courseList = await CDbManager.getInstance().getCourses();
        setState(() {
          loadingMessage = "Caching data...";
        });
        CCache().cacheCourses(courseList);

        // main screen
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return HomePage();
            }),
            (r) {
              return false;
            },
          );
        }
      }
    } catch (e) {
      widget.exceptionCallback(e);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset("assets/lottiefiles/paperplane.json"),
            CallistoText(
              loadingMessage,
              size: 20,
              weight: FontWeight.bold,
            )
          ],
        ),
      ),
    ));
  }
}
