import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static final TextStyle title = GoogleFonts.jost(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textOnSurface,
  );
  static final TextStyle subtitle = GoogleFonts.mulish(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
  );
  static final TextStyle onSurface = GoogleFonts.mulish(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textOnPrimary,
  );
  static final TextStyle headline = GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textThird,
    decoration: TextDecoration.underline,
  );
  static final TextStyle body = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textOnThird,
  );
  static final TextStyle tags = GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    color: AppColors.textInfo,
  );
  static final TextStyle info = GoogleFonts.mulish(
    fontSize: 8,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  static final TextStyle textFieldError = GoogleFonts.mulish(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.error,
  );
}
