import 'package:flutter/material.dart';
import 'package:jupiter_frontend/jupiter_frontend.dart';
import 'package:jupiter_frontend/services/sqlite_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.getInstance().initDB();
  runApp(const JupiterFrontendApp());
}
