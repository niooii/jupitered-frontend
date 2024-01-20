import 'package:flutter/material.dart';
import 'package:jupiter_frontend/jupiter_frontend.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:jupiter_frontend/services/shared_preferences.dart';

Future<void> cacheLocalCourses() async {
  final courseList = await CDbManager.getInstance().getCourses();
  CCache().cacheCourses(courseList);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CSharedPrefs().init();
  CSharedPrefs().load();
  await CDbManager.getInstance().initDB();
  // make sure tehres always something to work with.
  // jesus i need to refactor everything
  await cacheLocalCourses();

  runApp(const JupiterFrontendApp());
}
