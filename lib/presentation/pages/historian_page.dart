import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/data/models/historian.dart';
import 'package:aplikasi_budaya/presentation/widgets/app_bar.dart';
import 'package:aplikasi_budaya/presentation/widgets/text_field.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';

class HistorianPage extends StatelessWidget {
  final Historian data;
  const HistorianPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushReplacementNamed(
            context,
            '/historian/update',
            arguments: data,
          );
        },
        child: const Icon(
          Icons.edit_rounded,
          color: AppColors.textOnPrimary,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
              backgroundColor: AppColors.surface,
              backButtonCallback: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/list',
                  arguments: ListType.historian,
                );
              }),
          Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.surface,
            child: Column(
              children: [
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
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              children: [
                Text(
                  "Detail Profile",
                  style: AppStyles.title.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 8),
                _buildDetailItem(label: "Asal", value: data.from),
                _buildDetailItem(
                    label: "Tanggal Lahir", value: data.dateOfBirth),
                _buildDetailItem(label: "Jenis Kelamin", value: data.gender),
                const SizedBox(height: 16),
                Text(
                  "Tentang Profile",
                  style: AppStyles.title.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: Text(
                    data.description,
                    textAlign: TextAlign.justify,
                    style: AppStyles.body,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label :", style: AppStyles.subtitle),
        const SizedBox(height: 8),
        CustomTextField(
          controller: TextEditingController(text: value),
          enabled: false,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
