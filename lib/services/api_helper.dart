import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static ApiHelper? _instance;
  static late Uri _endpoint;

  ApiHelper._() {
    // no ddos thanks i will prob host it somewhere else later maybe perhaps
    // test endpoint
    // _endpoint = Uri.parse("https://jsonplaceholder.typicode.com/users");
    // _endpoint = Uri.http()
    //
  }

  // ? why is this async???
  static Future<ApiHelper> getInstance() async {
    _instance ??= ApiHelper._();

    return _instance!;
  }

  getAssignments(String user, String pass) async {
    // JsonDecoder decoder = const JsonDecoder();
    var response = await http.get(Uri.http(
        "96.246.237.185:9090", "/jupiter", {"osis": user, "password": pass}));
    print(response.statusCode);
    return response;
  }

  validateInfo(String user, String pass) async {
    // JsonDecoder decoder = const JsonDecoder();
    var response = await http.get(Uri.http(
        "96.246.237.185:9090", "/login_jupiter", {"osis": user, "password": pass}));
    print(response.statusCode);
    return response;
  }

  static testLoadingScreen() async {
    // wait 2 seconds
    return Future.delayed(Duration(seconds: 2));
  }
}
