import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/data/models/historian.dart';
import 'package:aplikasi_budaya/presentation/widgets/app_bar.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';

class HistorianPage extends StatelessWidget {
  final Historian data;
  const HistorianPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
        child: Column(children: [
      const CustomAppBar(),
      Center(
        child: ClipOval(
          child: FadeInImage(
            placeholder: const AssetImage(imagePlaceholder),
            image: NetworkImage(data.image.getImageUrl()),
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Center(child: Text(data.name, style: AppStyles.title)),
      Center(child: Text(data.from, style: AppStyles.subtitle)),
      const SizedBox(height: 24),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          color: AppColors.surface,
          child: ListView(
            children: [
              Text(
                data.description,
                textAlign: TextAlign.justify,
                style: AppStyles.body,
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
