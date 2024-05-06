import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/data/repositories/user_repo.dart';
import 'package:aplikasi_budaya/presentation/widgets/button.dart';
import 'package:aplikasi_budaya/presentation/widgets/text_field.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserRepository _userRepo = UserRepository();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _usernameError = '';
  String _passwordError = '';
  bool _isPasswordVisible = false, _isLoading = false;

  bool _isValid() =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  void _validate() {
    setState(() {
      _usernameError =
          _usernameController.text.isEmpty ? 'Username cannot be empty' : '';
      _passwordError =
          _passwordController.text.isEmpty ? 'Password cannot be empty' : '';
    });
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _userRepo.login(
        _usernameController.text,
        _passwordController.text,
      );
      setState(() {
        Navigator.pushReplacementNamed(context, '/home');
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        showSnackbar(context, e.toString().getExceptionMessage());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            const SizedBox(height: 32),
            Image.asset(
              'assets/images/icon.png',
              width: 128,
              height: 128,
            ),
            const SizedBox(height: 64),
            Text("Let's Sign In!", style: AppStyles.title),
            const SizedBox(height: 12),
            Text("Login to Your Account to Continue",
                style: AppStyles.subtitle),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _usernameController,
              hintText: 'Username',
              errorText: _usernameError,
              prefix: const Icon(
                Icons.person_rounded,
                color: AppColors.textSecondary,
              ),
              onChanged: (value) {
                _validate();
              },
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _passwordController,
              hintText: 'Password',
              obscureText: !_isPasswordVisible,
              errorText: _passwordError,
              prefix: const Icon(
                Icons.lock_rounded,
                color: AppColors.textSecondary,
              ),
              suffix: IconButton(
                icon: Icon(
                  !_isPasswordVisible
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              onChanged: (value) {
                _validate();
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Remember me", style: AppStyles.subtitle),
                Text("Forgot password?", style: AppStyles.subtitle),
              ],
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: "Sign In",
              enabled: !_isLoading,
              onTap: () {
                _validate();
                if (_isValid()) {
                  _login();
                }
              },
            ),
            const SizedBox(height: 24),
            Center(child: Text('Or continue with', style: AppStyles.subtitle)),
            const SizedBox(height: 24),
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
