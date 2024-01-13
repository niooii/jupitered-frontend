import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class User {
  String username;
  String? password;

  User(this.username, [this.password]);
  
  void LoadUser(String saved) {
    rootBundle.loadString("assets/userdata.json").then((value) {
      var data = JsonDecoder().convert(value);
      username = data["username"];
      password = data["password"];
    });
  }

  void saveUser(){
    File file = File("assets/userdata.json");
    file.writeAsStringSync(JsonEncoder().convert({"username": username, "password": password}));
    
  }

  get getUsername => username;
  get getPassword => password;

}