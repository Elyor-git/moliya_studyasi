import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.controller,
    required this.icon,
    required this.focusNode,
    required this.hintText,
    required this.function,
    required this.textCapitalization,
    required this.regExp,
    super.key,
  });

  final TextEditingController controller;
  final IconData icon;
  final FocusNode focusNode;
  final String hintText;
  final Function(String) function;
  final TextCapitalization textCapitalization;
  final RegExp regExp;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 8),
            color: AppColors.blackShadow10,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 45.w),
        child: TextField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(widget.regExp)
          ],
          focusNode: widget.focusNode,
          controller: widget.controller,
          onChanged: widget.function,
          onTapOutside: (val) {
            FocusScope.of(context).unfocus();
          },
          textCapitalization: widget.textCapitalization,
          cursorRadius: const Radius.circular(40),
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 15.sp,
          ),
          cursorColor: AppColors.greyTextColor,
          decoration: InputDecoration(
            fillColor: AppColors.white,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.greyTextColor,
            ),
            prefixIcon: Icon(
              widget.icon,
              size: 33.sp,
              color: AppColors.grey,
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              borderSide: BorderSide.none,
            ),
            disabledBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
