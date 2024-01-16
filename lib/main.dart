import 'package:flutter/material.dart';
import 'package:jupiter_frontend/jupiter_frontend.dart';
import 'package:jupiter_frontend/services/db_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CDbManager.getInstance().initDB();

  runApp(const JupiterFrontendApp());
}
