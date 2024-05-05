import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  String? username;
  bool isLogin = false;
  bool isFirstTime = true;

  Future<void> saveSession(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("username", username);
    pref.setBool("isLogin", true);
    pref.setBool("isFirstTime", false);
  }

  Future<Map<String, bool>> getSession() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return {
      'isLogin': pref.getBool('isLogin') ?? false,
      'isFirstTime': pref.getBool('isFirstTime') ?? true,
    };
  }

  Future<String?> getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('username');
  }

  Future<void> deleteSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
