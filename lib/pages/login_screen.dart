import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/pages/loading_screen.dart';
import 'package:jupiter_frontend/services/api_manager.dart';

import 'package:jupiter_frontend/models/user.dart';
import 'package:jupiter_frontend/services/db_manager.dart';

class LoginScreen extends StatefulWidget {
  bool _rememberMe = false;

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _osisController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _invalidOsis = false;
  bool _wrongPassword = false;

  String osisError = "";

  User u = User.empty();

  @override
  void initState() {
    u.loadUserData().whenComplete(() {
      if (u.getUsername != "") {
        _osisController.text = u.getUsername;
        _passwordController.text = u.getPassword;
        widget._rememberMe = true;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            "Login Page",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
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
                      child: Image.asset('assets/images/jupiter-transparent.png')),
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
                padding:
                    EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  obscureText: true,
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
                    value: widget._rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        widget._rememberMe = value!;
                      });
                    },
                  ),
                  Text("Remember Me",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground
                      )
                    )
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
                  onPressed: () {
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

                    var res = CApiManager.getInstance().then(
                      (value) =>
                        value.validateInfo(
                            _osisController.text, _passwordController.text)
                          );

                    errorCallback(String responseString) {
                      if (responseString
                          .contains("Could not find that student ID")) {
                        setState(() {
                          _invalidOsis = true;
                          osisError = "Could not find osis.";
                        });
                      } else if (responseString
                          .contains("That password is wrong")) {
                        setState(() {
                          _wrongPassword = true;
                        });
                      }
                    }

                    successCallback() async {
                      if (widget._rememberMe) {
                        u.saveUser(
                            _osisController.text, _passwordController.text);
                      }
                      await CApiManager.getInstance().then((APIval) => APIval
                              .getAssignments(
                                  _osisController.text, _passwordController.text)
                          .then((responseval) async => {
                                await CDbManager.getInstance()
                                    .storeApiResponse(responseval.body)
                                    .then((value) =>
                                        print("response saved?: ${value == 1}")),
                              }));
                    }

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoadingPage(res, errorCallback, successCallback);
                      },
                    ));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
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
