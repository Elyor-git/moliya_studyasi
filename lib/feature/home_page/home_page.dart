import 'package:flutter/material.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage1),
            fit: BoxFit.fill,
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
