import 'package:shared_preferences/shared_preferences.dart';

class CSharedPrefs {
  late SharedPreferences prefs;
  static CSharedPrefs? _instance;

  late bool rememberMe;
  late bool autoLogIn;
  String? osis;
  String? password;
  String? name;

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
    prefs.setBool("autoLogIn", autoLogIn);
    prefs.setBool("rememberMe", rememberMe);
    
    if(osis != null) {
      prefs.setString("osis", osis!);
    }

    if(password != null) {
      prefs.setString("password", password!);
    }

    if(name != null) {
      prefs.setString("name", name!);
    }
  }
  
  void load() {
    autoLogIn = prefs.getBool("autoLogIn") ?? false;
    rememberMe = prefs.getBool("rememberMe") ?? false;
    osis = prefs.getString("osis");
    password = prefs.getString("password");
    name = prefs.getString("name");
  }

}