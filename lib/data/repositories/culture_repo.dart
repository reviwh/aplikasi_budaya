import 'package:aplikasi_budaya/data/datasource/api/api_service.dart';
import 'package:aplikasi_budaya/data/models/culture.dart';
import 'package:aplikasi_budaya/data/models/response.dart';

class CultureRepository { 
  final ApiService _apiService = ApiService();

  Future<Response<Culture>> getCulture() async => await _apiService.getCulture();
}