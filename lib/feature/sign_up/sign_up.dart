import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/common/widget/custom_textfield.dart';

import '../../common/const/app_consts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  @override
  void initState() {
    _nameFocusNode.addListener(() { });
    super.initState();
  }

  @override
  void dispose() {
     _nameController.dispose();
     _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage3),
            fit: BoxFit.fill,
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
            //  SizedBox(height: 166.h),
              Text(
                textScaler: TextScaler.noScaling,
                AppTexts.akkauntYaratish,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 42.h),
              // CustomTextField(
              //   textCapitalization: TextCapitalization.none,
              //   function: (s){},
              //   controller: _nameController,
              //   icon: Icons.person_rounded,
              //   focusNode: _nameFocusNode,
              //   hintText: AppTexts.ism,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}



