import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/data/models/culture.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';

class CultureCard extends StatelessWidget {
  final Culture data;

  const CultureCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Card(
        color: AppColors.thirdWithOpacity,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/info', arguments: data);
          },
          splashColor: AppColors.third,
          borderRadius: BorderRadius.circular(32),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInImage.assetNetwork(
                  placeholder: imagePlaceholder,
                  image: data.image.getImageUrl(),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 24),
                Text(
                  data.title.toUpperCase(),
                  style: AppStyles.headline.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  data.content,
                  maxLines: 4,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.body.copyWith(
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    data.created.getFormattedDate(),
                    style: AppStyles.tags,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
