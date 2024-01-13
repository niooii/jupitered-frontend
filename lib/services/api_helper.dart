import 'dart:convert';

class ApiHelper {
  static ApiHelper? _instance;
  static late Uri _endpoint;
  
  static Future<ApiHelper> getInstance() async {
    _instance ??= ApiHelper();

    // no ddos thanks i will prob host it somewhere else later maybe perhaps
    _endpoint = Uri.parse("96.246.237.185:9090/jupiter");

    return _instance!;
  }

  Future<Map<String, dynamic>> getAssignments() async {
    JsonDecoder decoder = JsonDecoder();
    var response = await http.get(_endpoint);
    return decoder.convert(response.body);
  }

  
}