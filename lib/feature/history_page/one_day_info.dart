import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';
import 'package:moliya_studyasi/common/style/app_colors.dart';

class OneDayInfo extends StatelessWidget {
 final String day;
 final String checkIn;
 final String checkOut;
 final String weekDay;

  const OneDayInfo({
    required this.day,
    required this.checkIn,
    required this.checkOut,
    required this.weekDay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackShadow10,
              offset: const Offset(0, 8),
              blurRadius: 20,
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: SizedBox(
          height: 140.h,
          width: 333.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  gradient: LinearGradient(
                    colors: AppColors.button,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SizedBox(
                  height: 140.h,
                  width: 85.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weekDay,
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                        ),
                      ),
                      Text(
                        day,
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 33.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 140.h,
                width: 248.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppTexts.kirish,
                          style: TextStyle(
                            fontSize: 23.sp,
                            color: AppColors.greyTextColor,
                          ),
                        ),
                        Text(
                          checkIn,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppTexts.chiqish,
                          style: TextStyle(
                            fontSize: 23.sp,
                            color: AppColors.greyTextColor,
                          ),
                        ),
                        Text(
                          checkOut,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
