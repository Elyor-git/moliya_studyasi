import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';
import 'package:moliya_studyasi/common/style/app_colors.dart';
import 'package:moliya_studyasi/common/widget/avatar_image.dart';

import 'qr_code/qr_code_scanner_camera.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _whichMonth(int month) {
    return switch (month) {
      1 => "Yan",
      2 => "Fev",
      3 => "Mar",
      4 => "Apr",
      5 => "May",
      6 => "Iyn",
      7 => "Iyl",
      8 => "Avg",
      9 => "Sen",
      10 => "Okt",
      11 => "Noy",
      12 => "Dek",
      _ => "",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage3),
            fit: BoxFit.fill,
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 15, top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AvatarImage(size: 40.dg, backgroundSize: 88.dg),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                AppTexts.hushKelibsiz,
                                style: TextStyle(
                                  color: AppColors.blackTextColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${$storage.get(StorageKeys.surname.name)} ${$storage.get(StorageKeys.name.name)}",
                                style: TextStyle(
                                  color: AppColors.blackTextColor,
                                  fontSize: 23.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: ()  async  {
                          // todo open history and make widgets from firebase
                        },
                        child: Image(
                          width: 33.sp,
                          height: 33.sp,
                          image: const AssetImage(AppImages.schedule),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 52.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.status,
                      style: TextStyle(
                        color: AppColors.blackTextColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.blackShadow10,
                              blurRadius: 20,
                              offset: const Offset(0, 8)),
                        ],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      child: SizedBox(
                        height: 150.h,
                        width: 352.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppTexts.kirish,
                                  style: TextStyle(
                                    color: AppColors.greyTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23.sp,
                                  ),
                                ),
                                Text(
                                  "19:30",
                                  style: TextStyle(
                                    color: AppColors.blackTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.sp,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppTexts.chiqish,
                                  style: TextStyle(
                                    color: AppColors.greyTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23.sp,
                                  ),
                                ),
                                Text(
                                  "--:--",
                                  style: TextStyle(
                                    color: AppColors.blackTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.sp,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateTime.now().day} ${_whichMonth(DateTime.now().month)} ${DateTime.now().year}",
                            style: TextStyle(
                              fontSize: 23.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackTextColor,
                            ),
                          ),
                          StreamBuilder(
                            builder: (context, snapshot) {
                              return Text(
                                DateFormat("HH:mm:ss").format(DateTime.now()),
                                style: TextStyle(
                                  color: AppColors.greyTextColor,
                                  fontSize: 22.sp,
                                ),
                              );
                            },
                            stream: Stream.periodic(const Duration(seconds: 1)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () {
                    // todo
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QrCodeScanner(),
                      ),
                    );
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackShadow10,
                            offset: const Offset(0, 8),
                            blurRadius: 20,
                          ),
                        ]),
                    child: SizedBox.square(
                      dimension: 250.w,
                      child: Transform.scale(
                        scale: 0.7,
                        child: const Image(
                          image: AssetImage(AppImages.camera),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
