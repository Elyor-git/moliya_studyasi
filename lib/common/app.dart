import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/feature/login_page/login.dart';
import 'package:moliya_studyasi/feature/sign_up/sign_up.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Lato"),
        debugShowCheckedModeBanner: false,
        home: const Login(),
      ),
    );
  }
}
