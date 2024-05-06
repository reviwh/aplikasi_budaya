import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/data/models/historian.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';

class HistorianTile extends StatelessWidget {
  final Historian data;
  final Function(String)? deleteCallback;
  const HistorianTile({
    super.key,
    required this.data,
    this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/historian', arguments: data);
          },
          hoverColor: AppColors.surface.withOpacity(.5),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          title: Text(data.name, style: AppStyles.title.copyWith(fontSize: 18)),
          subtitle: Text(data.from, style: AppStyles.subtitle),
          leading: CircleAvatar(
            backgroundImage: const AssetImage(imagePlaceholder),
            foregroundImage: NetworkImage(data.image.getImageUrl()),
          ),
          trailing: IconButton(
            onPressed: () {
              if (deleteCallback != null) {
                deleteCallback!(data.id);
              }
            },
            icon: const Icon(
              Icons.delete_rounded,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const Divider(height: 2, color: AppColors.surface, thickness: 2),
      ],
    );
  }
}
