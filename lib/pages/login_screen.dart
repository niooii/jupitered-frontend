import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/pages/loading_screen.dart';
import 'package:jupiter_frontend/services/api_helper.dart';

class LoginScreen extends StatefulWidget {
  bool _rememberMe = false;

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _osisController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
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
                  checkColor: Colors.white,
                  // fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: widget._rememberMe,
                  onChanged: (bool? value) {
                    setState(() {
                      widget._rememberMe = value!;
                    });
                  },
                ),
                Text("Remember me")
              ],
            ),
            const Gap(10),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      Future login = ApiHelper.getInstance().then((value) =>
                          value.getAssignments(
                              _osisController.text, _passwordController.text));
                      login.then((value) => print(value.body));
                      return LoadingPage(login);
                    },
                  ));
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
