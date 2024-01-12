import 'dart:convert';

class User {
  String username;
  String? password;

  User(this.username, [this.password]);

  // write user data to json file
  // single responsibility principle
  // writeData() {
  //   Map<String, dynamic> data = {
  //     "username": username,
  //     "password": password,
  //   };
  //   String json = jsonEncode(data);
  //   rootBundle.write("assets/userdata.json", json);
  // }

  // readData() {
  //   dynamic json = rootBundle
  //       .loadString("assets/userdata.json")
  //       .then((value) => jsonDecode(value));
  //   username = json["username"];
  //   password = json["password"];
  // }

  // read user data from json file
}