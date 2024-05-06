import 'dart:async';

import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/data/repositories/user_repo.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _image = 'assets/images/logo.png';
  final UserRepository _userRepository = UserRepository();
  late String _nextPageRoute;

  @override
  void initState() {
    super.initState();
    _userRepository.getSession().then((value) {
      setState(() {
        _nextPageRoute = value['isLogin']! ? '/home' : '/login';
      });
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _image = 'assets/images/wonderful_indonesia.png';
      });
    });
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, _nextPageRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Image.asset(
            _image,
            width: 256,
            height: 256,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
