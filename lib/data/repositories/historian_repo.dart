import 'package:aplikasi_budaya/data/datasource/api/api_service.dart';
import 'package:aplikasi_budaya/data/models/historian.dart';
import 'package:aplikasi_budaya/data/models/response.dart';

class HistorianRepository {
  final ApiService _apiService = ApiService();

  Future<Response<Historian>> getHistorian() async =>
      await _apiService.getHistorian();
  Future<Response> addHistorian(Historian data) async =>  await _apiService.createHistorian(data);
}
