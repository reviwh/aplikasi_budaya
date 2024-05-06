import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/data/models/user.dart';
import 'package:aplikasi_budaya/data/repositories/user_repo.dart';
import 'package:aplikasi_budaya/presentation/widgets/app_bar.dart';
import 'package:aplikasi_budaya/presentation/widgets/button.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User _user = User.empty();
  bool _isLoading = true;

  Future<void> getUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await UserRepository().getUser();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        showSnackbar(context, e.toString().getExceptionMessage());
      });
    }
  }

  Future<void> _logout() async {
    await UserRepository().deleteSession();
    setState(() {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? buildLoadingView()
          : _user != User.empty()
              ? _buildContent(context)
              : buildEmptyView(),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      const CustomAppBar(),
      Expanded(
        child: ListView(
          children: [
            Center(
              child: Container(
                width: 120,
                height: 120,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 4, color: AppColors.primary),
                  image: const DecorationImage(
                    image: NetworkImage('https://placehold.co/120x120'),
                  ),
                ),
              ),
            ),
            Center(child: Text(_user.fullname, style: AppStyles.title)),
            Center(child: Text(_user.email, style: AppStyles.subtitle)),
            const SizedBox(height: 24),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              hoverColor: AppColors.surface.withOpacity(.25),
              title: Text(
                "Edit Profile",
                style: AppStyles.title.copyWith(fontSize: 16),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset('assets/images/person.png'),
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.secondary,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/profile/edit',
                  arguments: _user,
                );
              },
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(32.0),
        child: CustomButton(
          text: 'Logout',
          onTap: () {
            _logout();
          },
        ),
      )
    ]));
  }
}
