import 'dart:async';

import 'package:aplikasi_budaya/data/datasource/api/api_service.dart';
import 'package:aplikasi_budaya/data/datasource/pref/session_manager.dart';
import 'package:aplikasi_budaya/data/models/response.dart';
import 'package:aplikasi_budaya/data/models/user.dart';

class UserRepository {
  final ApiService _apiService = ApiService();
  final SessionManager _sessionManager = SessionManager();

  Future<void> login(String username, String password) async {
    await _apiService.login(username, password);
    await saveSession(username);
  }

  Future<Response> register(User user, String password) async =>
      await _apiService.register(user, password);

  Future<User> getUser() async {
    String? username = await _sessionManager.getUsername();
    return await _apiService.getUser(username!);
  }

  Future<Response> updateUser(User user) async =>
      await _apiService.updateUser(user);

  Future saveSession(String username) async =>
      await _sessionManager.saveSession(username);

  Future<Map<String, bool>> getSession() async =>
      await _sessionManager.getSession();

  Future deleteSession() async => await _sessionManager.deleteSession();
}
