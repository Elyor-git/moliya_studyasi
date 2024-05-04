import 'package:flutter/material.dart';

import '../const/app_consts.dart';
import '../style/app_colors.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({
    required this.backgroundSize,
    required this.size,
    super.key,
  });

  final double size;
  final double backgroundSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: AppColors.avatarBorder,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SizedBox.square(
            dimension: backgroundSize,
          ),
        ),
        CircleAvatar(
          radius: size,
          foregroundImage: const AssetImage(AppImages.user),
        ),
      ],
    );
  }
}
