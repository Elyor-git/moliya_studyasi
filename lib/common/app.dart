import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';
import 'package:moliya_studyasi/feature/home_page/home_page.dart';
import 'package:moliya_studyasi/feature/login_page/login.dart';
import 'package:moliya_studyasi/feature/login_page/login_repository/login_repository.dart';

import '../feature/login_page/login_bloc/login_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Lato"),
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => LoginBloc(loginRepository: LoginRepository()),
            )
          ],
          child:  $storage.getString(StorageKeys.employeeId.name) == null ? const Login() : const HomePage() ,
        ),
      ),
    );
  }
}
