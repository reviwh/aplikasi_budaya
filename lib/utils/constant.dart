import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

const String imagePlaceholder = 'assets/images/image_placeholder.png';

enum ListType { culture, historian }

showSnackbar(BuildContext context, String e) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text(
          e.toString(),
          style: AppStyles.onSurface.copyWith(fontSize: 14),
        ),
      ),
    );

buildEmptyView() =>
    Center(child: Text("Data not found", style: AppStyles.title));

buildLoadingView() => const Center(child: CircularProgressIndicator());
