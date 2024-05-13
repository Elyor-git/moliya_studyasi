import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';
import 'package:moliya_studyasi/common/style/app_colors.dart';
import 'package:moliya_studyasi/feature/history_page/one_day_info.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String engWeekToUz(String weekDay) {
      return switch (weekDay) {
        "Mon" => "Dush",
        "Tue" => "Sesh",
        "Wed" => "Chor",
        "Thu" => "Pay",
        "Fri" => "Jum",
        "Sat" => "Shan",
        "Sun" => "Yak",
        _ => ""
      };
    }

    String engMonthToUz(DateTime time) {
      return switch (time.month) {
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
        _ => ""
      };
    }

    String correctMonth(DateTime time) {
      return switch (time.month) {
        1 => "01",
        2 => "02",
        3 => "03",
        4 => "04",
        5 => "05",
        6 => "06",
        7 => "07",
        8 => "08",
        9 => "09",
        10 => "10",
        11 => "11",
        12 => "12",
        _ => ""
      };
    }

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
                        engMonthToUz(dateTime),
                        style: TextStyle(
                          color: AppColors.blackTextColor,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                insetPadding: const EdgeInsets.symmetric(
                                    vertical: 200, horizontal: 50),
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.monthYear,
                                  minimumYear: 2024,
                                  onDateTimeChanged: (DateTime time) {
                                    setState(() {
                                      dateTime = time;
                                    });
                                  },
                                ),
                              );
                            },
                          );
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
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Employees")
                          .doc($storage.getString(StorageKeys.firebaseId.name))
                          .collection("Davomat")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final snap = snapshot.data!.docs;
                          return ListView.builder(
                              itemCount: snap.length,
                              itemBuilder: (context, index) {
                                return DateFormat("MMyyyy").format(snap[index]["date"].toDate()) ==
                                        "${correctMonth(dateTime)}${dateTime.year}"
                                    ? OneDayInfo(
                                        weekDay: engWeekToUz(DateFormat("EE")
                                            .format(
                                                snap[index]["date"].toDate())),
                                        day: DateFormat("dd").format(
                                            snap[index]["date"].toDate()),
                                        checkIn: snap[index]["kirish"],
                                        checkOut: snap[index]["chiqish"],
                                      )
                                    : const SizedBox();
                              });
                        } else {
                          return const SizedBox();
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
