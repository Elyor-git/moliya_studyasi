import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:moliya_studyasi/common/config/month_take_mixin.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';
import 'package:moliya_studyasi/common/style/app_colors.dart';
import 'package:moliya_studyasi/common/widget/avatar_image.dart';
import 'package:moliya_studyasi/feature/home_page/qr_code/qr_code_bloc/location/location_service.dart';
import 'package:moliya_studyasi/feature/home_page/todays_status/today_status_bloc/today_status_bloc.dart';
import 'package:moliya_studyasi/feature/home_page/todays_status/todays_status_repository/todays_status_repository.dart';

import '../history_page/history_page.dart';
import '../profile_page/profile.dart';
import 'qr_code/qr_code_scanner_camera.dart';

class HomePage extends StatefulWidget  {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MonthTake  {


  late final TodayStatusBloc bloc;

  @override
  void initState() {
    bloc = TodayStatusBloc(repository: TodayStatusRepository());
    bloc.add(TodayStatus());
    _getPermission();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void _getPermission () async{
   await LocationService().takePermission();
  }

  bool _loading = false;

  String checkIn = "--:--";
  String checkOut = "--:--";

  bool _cameraOff = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodayStatusBloc>(
      create: (_) => bloc,
      child: Scaffold(
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
              child: RefreshIndicator(
                onRefresh: () async {
                  bloc.add(TodayStatus());
                },
                child: ListView(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Profile(),
                                    ),
                                  );
                                },
                                child: AvatarImage(
                                  size: 40.dg,
                                  backgroundSize: 88.dg,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    AppTexts.hushKelibsiz,
                                    style: TextStyle(
                                      color: AppColors.blackTextColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 240.w,
                                    child: Text(
                                      "${$storage.get(StorageKeys.surname.name)} ${$storage.get(StorageKeys.name.name)}",
                                      style: TextStyle(
                                        color: AppColors.blackTextColor,
                                        fontSize: 23.sp,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HistoryPage(),
                                ),
                              );
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                              child: BlocListener<TodayStatusBloc,
                                  TodayStatusState>(
                                listener: (_, state) {
                                  if (state is TodayLoadedState) {
                                    setState(() {
                                      _loading = false;
                                      checkIn = state.checkIn;
                                      checkOut = state.checkOut;
                                      if (state.checkOut != "--:--") {
                                        _cameraOff = true;
                                      }
                                    });
                                  } else if (state is TodayLoadingState) {
                                    setState(() {
                                      _loading = true;
                                    });
                                  } else if (state is TodayErrorState) {
                                    setState(() {
                                      _loading = false;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  height: 150.h,
                                  width: 352.w,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppTexts.kirish,
                                            style: TextStyle(
                                              color: AppColors.greyTextColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 23.sp,
                                            ),
                                          ),
                                          _loading
                                              ? const CircularProgressIndicator()
                                              : Text(
                                                  checkIn,
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .blackTextColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30.sp,
                                                  ),
                                                )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppTexts.chiqish,
                                            style: TextStyle(
                                              color: AppColors.greyTextColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 23.sp,
                                            ),
                                          ),
                                          _loading
                                              ? const CircularProgressIndicator()
                                              : Text(
                                                  checkOut,
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .blackTextColor,
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
                            ),
                            SizedBox(height: 25.h),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${DateTime.now().day} ${whichMonth(DateTime.now().month)} ${DateTime.now().year}",
                                    style: TextStyle(
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blackTextColor,
                                    ),
                                  ),
                                  StreamBuilder(
                                    builder: (context, snapshot) {
                                      return Text(
                                        DateFormat("HH:mm:ss")
                                            .format(DateTime.now()),
                                        style: TextStyle(
                                          color: AppColors.greyTextColor,
                                          fontSize: 22.sp,
                                        ),
                                      );
                                    },
                                    stream: Stream.periodic(
                                        const Duration(seconds: 1)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    _cameraOff
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60.sp),
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
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 180.sp,
                                  color: AppColors.blue,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QrCodeScanner(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 60.sp),
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
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
