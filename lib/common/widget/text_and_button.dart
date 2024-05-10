import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/common/style/app_colors.dart';

class TextAndButton extends StatelessWidget {
  const TextAndButton({
    required this.text,
    required this.onTap,
    required this.paddingFromRight,
    required this.paddingFromMiddle,
    required this.icon,
    super.key,
  });

  final String text;
  final double paddingFromRight;
  final double paddingFromMiddle;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: TextStyle(
            color: AppColors.blackTextColor,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: paddingFromMiddle),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(50.sp),
            ),
            gradient: LinearGradient(colors: AppColors.button),
          ),
          child: IconButton(
            style: ButtonStyle(
              fixedSize: MaterialStatePropertyAll(
                Size(70.w, 34.h),
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.sp),
                  ),
                ),
              ),
            ),
            onPressed: onTap,
            icon: icon,
          ),
        ),
        SizedBox(width: paddingFromRight),
      ],
    );
  }
}
