import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiHelper {
  static ApiHelper? _instance;
  static late Uri _endpoint;

  ApiHelper._() {
     // no ddos thanks i will prob host it somewhere else later maybe perhaps
    _endpoint = Uri.parse("96.246.237.185:9090/jupiter");
  }
  
  static Future<ApiHelper> getInstance() async {
    _instance ??= ApiHelper._();
    
    return _instance!;
  }





  Future<Map<String, dynamic>> getAssignments() async {
    JsonDecoder decoder = JsonDecoder();
    var response = await http.get(_endpoint);
    return decoder.convert(response.body);
  }

  
}