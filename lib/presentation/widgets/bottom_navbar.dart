import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 84,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNavbarItem(
            icon: 'assets/images/home.png',
            label: 'Home',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
            },
          ),
          _buildNavbarItem(
            icon: 'assets/images/list.png',
            label: 'List',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/list', (_) => false);
            },
          ),
          _buildNavbarItem(
            icon: 'assets/images/person.png',
            label: 'Profile',
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavbarItem({
    required String icon,
    required String label,
    required Function() onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppStyles.info,
            ),
          ],
        ),
      ),
    );
  }
}
