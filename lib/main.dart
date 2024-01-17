import 'package:flutter/material.dart';
import 'package:jupiter_frontend/jupiter_frontend.dart';
import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:jupiter_frontend/services/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CSharedPrefs().init();
  CSharedPrefs().load();
  await CDbManager.getInstance().initDB();

  runApp(const JupiterFrontendApp());
}
