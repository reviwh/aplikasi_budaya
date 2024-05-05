import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/presentation/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Let\'s you in', style: AppStyles.title),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                      icon: Image.asset('assets/images/google.png')),
                  const SizedBox(width: 12),
                  Text('Continue with Google', style: AppStyles.subtitle),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                      icon: Image.asset('assets/images/apple.png')),
                  const SizedBox(width: 12),
                  Text('Continue with iCloud', style: AppStyles.subtitle),
                ],
              ),
            ),
            const SizedBox(height: 64),
            Text('(Or)', style: AppStyles.subtitle),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: CustomButtonWithNext(
                  text: "Sign In with Your Account",
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/login')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account? ', style: AppStyles.subtitle),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/register'),
                  child: Text(
                    'SIGN UP',
                    style:
                        AppStyles.subtitle.copyWith(color: AppColors.textLink),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
