import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/common/app/app_bloc/app_bloc.dart';
import 'package:moliya_studyasi/common/app/app_bloc/app_event.dart';
import 'package:moliya_studyasi/common/app/app_reposetory/app_repository.dart';
import 'package:moliya_studyasi/feature/home_page/home_page.dart';
import 'package:moliya_studyasi/feature/login_page/login.dart';

import 'app_bloc/app_state.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppBloc bloc;

  @override
  void initState() {
    bloc = AppBloc(appRepository: AppRepository());
    bloc.add(AppCheckEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Lato"),
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (_) => bloc,
          child: BlocConsumer<AppBloc, AppState>(
            listener: (context, state) {
              if (state is AppUserNotFoundState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              } else if (state is AppUserFoundState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              } else if (state is AppErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (BuildContext context, AppState state) {
              if (state is AppLoadingState || state is AppInitial) {
                return const Scaffold(
                  body: Center(
                    child: SizedBox.square(
                      dimension: 30,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              } else {
                // This should not be reached
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
