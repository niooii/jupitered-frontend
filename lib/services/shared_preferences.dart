import 'package:shared_preferences/shared_preferences.dart';
// TODO!
// store settings here !

class CSharedPrefs {
  late SharedPreferences prefs;
  static CSharedPrefs? _instance;

  late bool autoLogIn;

  CSharedPrefs._();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  factory CSharedPrefs() {
    _instance ??= CSharedPrefs._();
    return _instance!;
  }

  void save() {
    print("wrote todisk");
  }
  
  void load() {
    autoLogIn = prefs.getBool("autoLogIn") ?? false;
  }

}