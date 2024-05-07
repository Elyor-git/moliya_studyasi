import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moliya_studyasi/common/app.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   $storage = await SharedPreferences.getInstance();
  runApp(const App());
}
