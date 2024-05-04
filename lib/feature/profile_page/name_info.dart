import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';
import 'package:moliya_studyasi/common/style/app_colors.dart';

class NameInfo extends StatelessWidget {
  const NameInfo({
    required this.surname,
    required this.name,
    super.key,
  });

  final String name;
  final String surname;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 43),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.familya,
            style: TextStyle(
              color: AppColors.greyTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: AppColors.blackShadow10,
                    offset: const Offset(0, 8),
                    blurRadius: 20),
              ],
              color: AppColors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: SizedBox(
              height: 55.h,
              width: 304.w,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, top: 5.h),
                child: Text(
                  surname,
                  style: TextStyle(
                    color: AppColors.blackTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 27.h,
          ),
          Text(
            AppTexts.ism,
            style: TextStyle(
              color: AppColors.greyTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: AppColors.blackShadow10,
                    offset: const Offset(0, 8),
                    blurRadius: 20),
              ],
              color: AppColors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: SizedBox(
              height: 55.h,
              width: 304.w,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, top: 5.h),
                child: Text(
                  name,
                  style: TextStyle(
                    color: AppColors.blackTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
