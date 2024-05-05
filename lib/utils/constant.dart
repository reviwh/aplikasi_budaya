import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

const String imagePlaceholder = 'assets/images/image_placeholder.png';

enum ListType { culture, historian }

showSnackbar(BuildContext context, String e) => ScaffoldMessenger.of(context)
    .showSnackBar(SnackBar(content: Text(e.toString())));

buildEmptyView() =>
    Center(child: Text("Data not found", style: AppStyles.title));

buildLoadingView() => const Center(child: CircularProgressIndicator());
