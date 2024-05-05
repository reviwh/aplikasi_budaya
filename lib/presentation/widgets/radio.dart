import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final void Function(T?)? onChanged;
  final String label;
  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: value, groupValue: groupValue, onChanged: onChanged),
        const SizedBox(width: 16),
        Text(label, style: AppStyles.subtitle),
      ],
    );
  }
}
