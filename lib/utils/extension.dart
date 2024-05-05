import 'package:aplikasi_budaya/data/models/culture.dart';
import 'package:aplikasi_budaya/data/models/historian.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String getFormattedDate() {
    initializeDateFormatting('id_ID', null);
    return '$day ${DateFormat('MMM', 'id_ID').format(this)} $year';
  }
}

extension CultureListExtension on List<Culture> {
  List<Culture> search(String q) {
    List<Culture> result = [];
    for (var e in this) {
      if (e.title.toString().toLowerCase().contains(q.toLowerCase())) {
        result.add(e);
      }
    }
    return result;
  }
}

extension HistorianListExtension on List<Historian> {
  List<Historian> search(String q) {
    List<Historian> result = [];
    for (var e in this) {
      if (e.name.toString().toLowerCase().contains(q.toLowerCase())) {
        result.add(e);
      }
    }
    return result;
  }
}

extension StringExtension on String {
  String getImageUrl() => '${dotenv.env['BASE_URL']}/gambar_berita/$this';
  String getExceptionMessage() {
    List<String> temp = split(': ');
    temp.removeAt(0);
    return temp.join(':');
  }
}
