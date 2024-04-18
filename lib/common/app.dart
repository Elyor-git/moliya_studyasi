import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/feature/home_page.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(390, 844),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        ),
    );
  }
}
