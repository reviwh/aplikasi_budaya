import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final Widget? trailing;
  final Color? backgroundColor;
  final Function()? backButtonCallback;

  const CustomAppBar({
    super.key,
    this.title,
    this.trailing,
    this.backgroundColor,
    this.backButtonCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      color: backgroundColor ?? AppColors.background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildBackButton(context),
          const SizedBox(width: 8),
          Expanded(child: Text(title ?? '', style: AppStyles.title)),
          const SizedBox(width: 8),
          trailing ?? Container(),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: backButtonCallback ??
          () {
            Navigator.pop(context);
          },
      child: Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/arrow_back.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
