import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.controller,
    required this.icon,
    required this.focusNode,
    required this.hintText,
    super.key,
  });

  final TextEditingController controller;
  final IconData icon;
  final FocusNode focusNode;
  final String hintText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 8),
              color: AppColors.blackShadow10,
              blurRadius: 20,
              blurStyle: BlurStyle.outer,
            )
          ]),
      child: SizedBox(
        height: 60.h,
        width: 300.w,
        child: TextField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          onTapOutside: (val) {
            FocusScope.of(context).unfocus();
          },
          cursorHeight: 25,
          cursorRadius: const Radius.circular(40),
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 18.sp,
          ),
          cursorColor: AppColors.greyTextColor,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 18.sp,
              color: AppColors.greyTextColor,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Icon(
                widget.icon,
                size: 33.sp,
                color: AppColors.grey,
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 22.h,
              right: 22.w,
            ),
            // error: const SizedBox.shrink(),
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
