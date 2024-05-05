import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/data/models/user.dart';
import 'package:aplikasi_budaya/data/repositories/user_repo.dart';
import 'package:aplikasi_budaya/presentation/widgets/app_bar.dart';
import 'package:aplikasi_budaya/presentation/widgets/button.dart';
import 'package:aplikasi_budaya/presentation/widgets/text_field.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final UserRepository _userRepo = UserRepository();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _fullnameError = '';
  String _usernameError = '';
  String _passwordError = '';
  String _noTelpError = '';
  String _nimError = '';
  String _emailError = '';
  String _addressError = '';

  bool _isLoading = false;

  bool _isValid() =>
      _fullnameError.isEmpty &&
      _usernameError.isEmpty &&
      _passwordError.isEmpty &&
      _noTelpError.isEmpty &&
      _nimError.isEmpty &&
      _emailError.isEmpty &&
      _addressError.isEmpty;

  void _validate() {
    setState(() {
      _fullnameError =
          _fullnameController.text.isEmpty ? 'Fullname cannot be empty' : '';
      _usernameError =
          _usernameController.text.isEmpty ? 'Username cannot be empty' : '';
      _passwordError =
          _passwordController.text.isEmpty ? 'Password cannot be empty' : '';
      _noTelpError =
          _noTelpController.text.isEmpty ? 'No. Telp cannot be empty' : '';
      _nimError = _nimController.text.isEmpty ? 'NIM cannot be empty' : '';
      _emailError =
          _emailController.text.isEmpty ? 'Email cannot be empty' : '';
      _addressError =
          _addressController.text.isEmpty ? 'Alamat cannot be empty' : '';
    });
  }

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final User user = User(
        id: "",
        username: _usernameController.text,
        fullname: _fullnameController.text,
        nim: _nimController.text,
        nohp: _noTelpController.text,
        email: _emailController.text,
        address: _addressController.text,
      );
      final res = await _userRepo.register(user, _passwordController.text);
      setState(() {
        showSnackbar(context, res.message);
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
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
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
        child: Column(children: [
      const CustomAppBar(),
      _buildBody(),
      Padding(
        padding: const EdgeInsets.all(32.0),
        child: CustomButton(
          text: "Sign Up",
          enabled: !_isLoading,
          onTap: () {
            _validate();
            if (_isValid()) {
              _register();
            }
          },
        ),
      )
    ]));
  }

  Widget _buildBody() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        children: [
          Text(
            "Let's Sign Up",
            style: AppStyles.title,
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: _fullnameController,
            hintText: "Full Name",
            errorText: _fullnameError,
            onChanged: (value) {
              _validate();
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _usernameController,
            hintText: "Username",
            errorText: _usernameError,
            onChanged: (value) {
              _validate();
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _passwordController,
            hintText: "Password",
            obscureText: true,
            errorText: _passwordError,
            onChanged: (value) {
              _validate();
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _noTelpController,
            hintText: "No. Telp",
            prefix: Padding(
              padding:
                  const EdgeInsets.only(left: 14.0, bottom: 4.0, right: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/flag_id.png',
                    width: 18,
                    height: 18,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(+62)',
                    style: AppStyles.subtitle.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            errorText: _noTelpError,
            onChanged: (value) {
              _validate();
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _nimController,
            hintText: "NIM",
            errorText: _nimError,
            onChanged: (value) {
              _validate();
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _emailController,
            hintText: "Email",
            errorText: _emailError,
            onChanged: (value) {
              _validate();
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _addressController,
            hintText: "Alamat",
            errorText: _addressError,
            onChanged: (value) {
              _validate();
            },
          ),
        ],
      ),
    );
  }
}
