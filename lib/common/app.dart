import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';
import 'package:moliya_studyasi/feature/home_page/home_page.dart';
import 'package:moliya_studyasi/feature/login_page/login.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Lato"),
        debugShowCheckedModeBanner: false,
        home: $storage.getString(StorageKeys.employeeId.name) == null
            ? const Login()
            : const HomePage(),
      ),
    );
  }
}
