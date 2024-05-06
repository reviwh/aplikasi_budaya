import 'package:aplikasi_budaya/data/datasource/api/api_service.dart';
import 'package:aplikasi_budaya/data/models/historian.dart';
import 'package:aplikasi_budaya/data/models/response.dart';

class HistorianRepository {
  final ApiService _apiService = ApiService();

  Future<Response<Historian>> getHistorian() async =>
      await _apiService.getHistorian();
  Future<Response> addHistorian(Historian data) async =>
      await _apiService.createHistorian(data);
  Future<Response> deleteHistorian(String id) async =>
      await _apiService.deleteHistorian(id);
  Future<Response<Historian>> updateHistorian(Historian data, bool isImagePicked) async =>
      await _apiService.updateHistorian(data, isImagePicked);
}
