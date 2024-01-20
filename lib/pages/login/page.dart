import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jupiter_frontend/pages/loading_screen.dart';
import 'package:jupiter_frontend/pages/login/obscured_text_controller.dart';
import 'package:jupiter_frontend/services/api_manager.dart';

import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:jupiter_frontend/services/shared_preferences.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _osisController = TextEditingController();
  final TextEditingController _passwordController =
      ObscuringTextEditingController();

  bool _invalidOsis = false;
  bool _wrongPassword = false;

  String osisError = "";

  void loginFunc() {
    // validation layers
    if (_osisController.text.length != 9) {
      setState(() {
        _invalidOsis = true;
        osisError = "Invalid osis entry.";
      });
      return;
    }

    // clear invalid states
    _invalidOsis = false;
    _wrongPassword = false;

    try {
      var res = CApiManager.getInstance().then((value) =>
          value.validateInfo(_osisController.text, _passwordController.text));

      exceptionCallback(Exception e) {
        setState(() {
          _invalidOsis = true;
          osisError = "Check your internet and try again.";
          print(e);
          print("intenret error possibly");
        });
      }

      errorCallback(String responseString) {
        if (responseString.contains("Could not find that student ID")) {
          setState(() {
            _invalidOsis = true;
            osisError = "Could not find osis.";
          });
        } else if (responseString.contains("That password is wrong")) {
          setState(() {
            _wrongPassword = true;
          });
        }
      }

      successCallback() async {
        // if (CSharedPrefs().rememberMe) {

        // }
        // need to save anyways for refetching data.
        // TODO! maybe make it so when rememberme is on, yea nevermind.
        CSharedPrefs().osis = _osisController.text;
        CSharedPrefs().password = _passwordController.text;
        CSharedPrefs().save();
        // TODO! absolutely demonic
        await CApiManager.getInstance().then((APIval) => APIval.getJupiterData(
                _osisController.text, _passwordController.text)
            .then((responseval) async => {
                  await CDbManager.getInstance()
                      .storeApiResponse(responseval.body)
                      .then((value) => print("response saved?: ${value == 1}")),
                }));
      }

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return LoadingPage(
              res, exceptionCallback, errorCallback, successCallback);
        },
      ));
    } catch (e) {
      setState(() {
        _invalidOsis = true;
        osisError = "Check your internet and try again.";
        print(e);
        print("intenret error possibly");
      });
    }
  }

  @override
  void initState() {
    String? osis;
    if (CSharedPrefs().rememberMe &&
        CSharedPrefs().osis != null &&
        CSharedPrefs().password != null) {
      _osisController.text = CSharedPrefs().osis!;
      _passwordController.text = CSharedPrefs().password!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(CSharedPrefs().triedAutoLogIn);
    // if(CSharedPrefs().autoLogIn && !CSharedPrefs().triedAutoLogIn) {
    //   loginFunc();
    //   CSharedPrefs().triedAutoLogIn = true;
    //   print("set autologin true");
    // }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            "Yet Another Jupiter Frontend",
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Center(
                  child: Container(
                      width: 300,
                      height: 200,
                      child:
                          Image.asset('assets/images/jupiter-transparent.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                      errorText: _invalidOsis ? osisError : null,
                      border: OutlineInputBorder(),
                      labelText: 'Osis',
                      hintText: 'Your 9-digit osis number.'),
                  controller: _osisController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  decoration: InputDecoration(
                      errorText: _wrongPassword ? "Incorrect password." : null,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Your jupiter password.'),
                  controller: _passwordController,
                ),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    checkColor: Theme.of(context).colorScheme.onSecondary,
                    fillColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.secondary),
                    value: CSharedPrefs().rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        CSharedPrefs().rememberMe = value!;
                        CSharedPrefs().save();
                      });
                    },
                  ),
                  Text("Remember Me",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground))
                ],
              ),
              const Gap(10),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: loginFunc,
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
