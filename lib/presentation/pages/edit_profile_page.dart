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

class EditProfilePage extends StatefulWidget {
  final User data;
  const EditProfilePage({super.key, required this.data});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final UserRepository _userRepo = UserRepository();

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  String _fullnameError = '';
  String _usernameError = '';
  String _noTelpError = '';
  String _nimError = '';
  String _emailError = '';
  String _alamatError = '';

  bool _isLoading = false;

  bool _isValid() =>
      _fullnameError.isEmpty &&
      _usernameError.isEmpty &&
      _noTelpError.isEmpty &&
      _nimError.isEmpty &&
      _emailError.isEmpty &&
      _alamatError.isEmpty;

  void _validate() {
    setState(() {
      _fullnameError =
          _fullnameController.text.isEmpty ? 'Fullname cannot be empty' : '';
      _usernameError =
          _usernameController.text.isEmpty ? 'Username cannot be empty' : '';
      _noTelpError =
          _noTelpController.text.isEmpty ? 'No. Telp cannot be empty' : '';
      _nimError = _nimController.text.isEmpty ? 'NIM cannot be empty' : '';
      _emailError =
          _emailController.text.isEmpty ? 'Email cannot be empty' : '';
      _alamatError =
          _alamatController.text.isEmpty ? 'Alamat cannot be empty' : '';
    });
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final User user = User(
        id: widget.data.id,
        fullname: _fullnameController.text,
        username: _usernameController.text,
        nohp: _noTelpController.text,
        nim: _nimController.text,
        email: _emailController.text,
        address: _alamatController.text,
      );

      final res = await _userRepo.updateUser(user);
      setState(() {
        Navigator.pushReplacementNamed(context, '/profile');
        _isLoading = false;
        showSnackbar(context, res.message);
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        showSnackbar(context, e.toString().getExceptionMessage());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fullnameController.text = widget.data.fullname;
    _usernameController.text = widget.data.username;
    _noTelpController.text = widget.data.nohp;
    _nimController.text = widget.data.nim;
    _emailController.text = widget.data.email;
    _alamatController.text = widget.data.address;
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
      CustomAppBar(
        backButtonCallback: () {
          Navigator.pushReplacementNamed(context, '/profile');
        },
      ),
      _buildBody(),
      Padding(
        padding: const EdgeInsets.all(32.0),
        child: CustomButton(
          text: "Update",
          enabled: !_isLoading,
          onTap: () {
            _validate();
            if (_isValid()) {
              _updateProfile();
            }
          },
        ),
      )
    ]));
  }

  Widget _buildBody() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Container(
            width: 96,
            height: 96,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 4, color: AppColors.primary),
              image: const DecorationImage(
                image: NetworkImage('https://placehold.co/96x96'),
              ),
            ),
          ),
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
            controller: _alamatController,
            hintText: "Alamat",
            errorText: _alamatError,
            onChanged: (value) {
              _validate();
            },
          ),
        ],
      ),
    );
  }
}
