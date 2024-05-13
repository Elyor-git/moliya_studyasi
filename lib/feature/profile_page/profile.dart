import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/common/style/app_colors.dart';
import 'package:moliya_studyasi/common/widget/avatar_image.dart';
import 'package:moliya_studyasi/feature/profile_page/name_info.dart';

import '../../common/const/app_consts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage1),
            fit: BoxFit.fill,
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SafeArea(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(),
                  ],
                ),
                SizedBox(height: 50.h),
                AvatarImage(
                  size: 65.dg,
                  backgroundSize: 140.dg,
                ),
                const SizedBox(height: 10),
                Text(
                  "${$storage.getString(StorageKeys.employeeId.name)}",
                  style: TextStyle(
                    color: AppColors.blackTextColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 45.h),
                NameInfo(
                  surname: "${$storage.getString(StorageKeys.surname.name)}",
                  name: "${$storage.getString(StorageKeys.name.name)}",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
