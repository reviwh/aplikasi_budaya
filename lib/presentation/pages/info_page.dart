import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/data/models/culture.dart';
import 'package:aplikasi_budaya/presentation/widgets/app_bar.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final Culture data;
  const InfoPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    image: DecorationImage(
                      image: NetworkImage(data.image.getImageUrl()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    data.title.toUpperCase(),
                    style: AppStyles.headline,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.thirdWithOpacity,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diunggah pada ${data.created.getFormattedDate()}',
                        style: AppStyles.tags,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        data.content,
                        textAlign: TextAlign.justify,
                        style: AppStyles.body,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
