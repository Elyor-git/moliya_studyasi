import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';
import 'package:moliya_studyasi/common/style/app_colors.dart';
import 'package:moliya_studyasi/feature/history_page/one_day_info.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage2),
            fit: BoxFit.fill,
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BackButton(
                      color: AppColors.blackTextColor,
                      style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(
                          Size(30.w, 30.h),
                        ),
                      ),
                    ),
                    Text(
                      AppTexts.tarix,
                      style: TextStyle(
                        color: AppColors.blackTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.sp,
                      ),
                    ),
                    SizedBox(width: 50.w),
                  ],
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "May",
                        // todo
                        // change month
                        style: TextStyle(
                          color: AppColors.blackTextColor,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // todo add month picker
                        },
                        child: Text(
                          AppTexts.oyniTanlang,
                          style: TextStyle(
                            color: AppColors.blackTextColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 162,
                  child: ListView(
                    children: const [
                      OneDayInfo(),
                      SizedBox(height: 10),
                      OneDayInfo(),
                      SizedBox(height: 10),
                      OneDayInfo(),
                      SizedBox(height: 10),
                      OneDayInfo(),
                      SizedBox(height: 10),
                      OneDayInfo(),
                      SizedBox(height: 10),
                      OneDayInfo(),
                      SizedBox(height: 10),
                      OneDayInfo(),
                    ],
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
