import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String? hintText;
  final Widget? prefix, suffix;
  final TextStyle? textStyle, hintStyle;
  final Function(String)? onChanged;
  final String errorText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final double? height;
  final TextCapitalization textCapitalization;

  const CustomTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.hintText,
    this.prefix,
    this.suffix,
    this.textStyle,
    this.hintStyle,
    this.onChanged,
    this.errorText = '',
    this.keyboardType,
    this.maxLines = 1,
    this.height,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            textCapitalization: textCapitalization,
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: textStyle ??
                AppStyles.subtitle.copyWith(color: AppColors.textPrimary),
            cursorColor: AppColors.secondary,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle ?? AppStyles.subtitle,
              prefixIcon: prefix,
              suffixIcon: suffix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        if (errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              errorText,
              style: AppStyles.textFieldError,
            ),
          ),
      ],
    );
  }
}
