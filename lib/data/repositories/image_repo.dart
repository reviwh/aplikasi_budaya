import 'package:aplikasi_budaya/data/datasource/api/api_service.dart';

class ImageRepository {
  final ApiService _apiService = ApiService();

  Future<List<String>> getImages() async => await _apiService.getImages();
}
