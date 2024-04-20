import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    required this.error,
    required this.isVisible,
    super.key,
  });

  final String error;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 65),
          child: Visibility(
            visible: isVisible,
            child: Text(
              error,
              style: TextStyle(
                color: AppColors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
