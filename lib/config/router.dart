import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/data/models/culture.dart';
import 'package:aplikasi_budaya/data/models/historian.dart';
import 'package:aplikasi_budaya/data/models/user.dart';
import 'package:aplikasi_budaya/presentation/pages/add_historian_page.dart';
import 'package:aplikasi_budaya/presentation/pages/edit_profile_page.dart';
import 'package:aplikasi_budaya/presentation/pages/gallery_page.dart';
import 'package:aplikasi_budaya/presentation/pages/historian_page.dart';
import 'package:aplikasi_budaya/presentation/pages/home_page.dart';
import 'package:aplikasi_budaya/presentation/pages/info_page.dart';
import 'package:aplikasi_budaya/presentation/pages/list_page.dart';
import 'package:aplikasi_budaya/presentation/pages/login_page.dart';
import 'package:aplikasi_budaya/presentation/pages/profile_page.dart';
import 'package:aplikasi_budaya/presentation/pages/register_page.dart';
import 'package:aplikasi_budaya/presentation/pages/splash_page.dart';
import 'package:aplikasi_budaya/presentation/pages/welcome_page.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/info':
        return args is Culture
            ? MaterialPageRoute(builder: (_) => InfoPage(data: args))
            : _errorRoute();
      // case '/list':
      //   return MaterialPageRoute(builder: (_) => const ListPage());
      case '/list':
        return args is ListType
            ? MaterialPageRoute(builder: (_) => ListPage(listType: args))
            : MaterialPageRoute(builder: (_) => const ListPage());
      case '/historian':
        return args is Historian
            ? MaterialPageRoute(builder: (_) => HistorianPage(data: args))
            : _errorRoute();
      case '/historian/add':
        return MaterialPageRoute(builder: (_) => const AddHistorianPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case '/profile/edit':
        return args is User
            ? MaterialPageRoute(builder: (_) => EditProfilePage(data: args))
            : _errorRoute();
      case '/gallery':
        return MaterialPageRoute(builder: (_) => const GalleryPage());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('Not Found 404', style: AppStyles.title),
        ),
      );
    });
  }
}
