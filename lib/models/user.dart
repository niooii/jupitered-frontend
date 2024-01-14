import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart';

class User {
  String username;
  String? password;

  User(this.username, [this.password]);
  User.empty() : this("", "");

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/userdata.json');
  }

  static User loadUser() {
    User ret = User.empty();
    rootBundle.loadString("assets/userdata.json").then((value) {
      var data = JsonDecoder().convert(value);
      ret.setUsername = data["username"];
      ret.setPassword = data["password"];
    });
    return ret;
  }

  Future<void> loadUserData() async {
    File file = await _localFile;
    if (file.existsSync()) {
      var data = JsonDecoder().convert(file.readAsStringSync());
      setUsername = data["username"];
      setPassword = data["password"];
    }
    print("loaded user data, username: $username, password: $password");
  }

  void saveUser(String user, String? pass) async {
    File file = await _localFile;
    // print files in current directory
    if (!file.existsSync()) {
      file.createSync();
    }

    file.writeAsStringSync(
        JsonEncoder().convert({"username": user, "password": pass ?? ""}));
  }

  get getUsername => username;
  get getPassword => password;

  set setUsername(String username) => this.username = username;
  set setPassword(String password) => this.password = password;
}
