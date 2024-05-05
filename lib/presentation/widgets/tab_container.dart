import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class TabContainer extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function() onTap;

  const TabContainer({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isActive ? AppColors.primary : AppColors.surface;
    Color textColor =
        isActive ? AppColors.textOnPrimary : AppColors.textOnSurface;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: isActive
              ? AppColors.surface.withOpacity(.25)
              : AppColors.primary.withOpacity(.5),
          borderRadius: BorderRadius.circular(24),
          child: Center(
            child: Text(
              title,
              style: AppStyles.onSurface.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
