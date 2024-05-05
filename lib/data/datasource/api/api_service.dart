import 'dart:convert';

import 'package:aplikasi_budaya/data/models/culture.dart';
import 'package:aplikasi_budaya/data/models/historian.dart';
import 'package:aplikasi_budaya/data/models/response.dart';
import 'package:aplikasi_budaya/data/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = dotenv.env["BASE_URL"] ?? "";

  Future<void> login(String username, String password) async {
    http.Response res = await http.post(
      Uri.parse("$_baseUrl/login.php"),
      body: {"username": username, "password": password},
    );

    Response<User> data = Response.fromJson(
      json.decode(res.body),
      (value) => User.fromJson(value),
    );

    if (!data.isSuccess) throw Exception(data.message);
  }

  Future<Response> register(User user, String password) async {
    http.Response res = await http.post(
      Uri.parse("$_baseUrl/register.php"),
      body: {
        "username": user.username,
        "fullname": user.fullname,
        "nim": user.nim,
        "nohp": user.nohp,
        "email": user.email,
        "alamat": user.address,
        "password": password,
      },
    );

    Response data = Response.fromJsonWithoutData(json.decode(res.body));

    if (!data.isSuccess) throw Exception(data.message);

    return data;
  }

  Future<User> getUser(String username) async {
    http.Response res = await http.post(
      Uri.parse("$_baseUrl/user.php"),
      body: {"username": username},
    );

    Response<User> data = Response.fromJson(
      json.decode(res.body),
      (value) => User.fromJson(value),
    );

    if (!data.isSuccess) throw Exception(data.message);

    return data.data.first;
  }

  Future<Response> updateUser(User user) async {
    http.Response res = await http.post(
      Uri.parse("$_baseUrl/updateuser.php"),
      body: {
        "id": user.id,
        "fullname": user.fullname,
        "username": user.username,
        "nohp": user.nohp,
        "nim": user.nim,
        "email": user.email,
        "alamat": user.address,
      },
    );

    Response data = Response.fromJsonWithoutData(json.decode(res.body));

    if (!data.isSuccess) throw Exception(data.message);

    return data;
  }

  Future<Response<Culture>> getCulture() async {
    http.Response res = await http.get(Uri.parse("$_baseUrl/berita.php"));

    Response<Culture> data = Response.fromJson(
      json.decode(res.body),
      (value) => Culture.fromJson(value),
    );

    if (!data.isSuccess) throw Exception(data.message);

    return data;
  }

  Future<Response<Historian>> getHistorian() async {
    http.Response res = await http.get(Uri.parse("$_baseUrl/sejarawan.php"));

    Response<Historian> data = Response.fromJson(
      json.decode(res.body),
      (value) => Historian.fromJson(value),
    );

    if (!data.isSuccess) throw Exception(data.message);

    return data;
  }

  Future<Response> createHistorian(Historian historian) async {
    var uri = Uri.parse("$_baseUrl/addsejarawan.php");
    var req = http.MultipartRequest("POST", uri)
      ..fields['name'] = historian.name
      ..files.add(
        http.MultipartFile.fromString('foto', historian.image),
      );
    var res = await req.send();

    print(res.stream.bytesToString());
    // Response data = Response.fromJsonWithoutData(json.decode(res.stream.bytesToString()));
    return Response(isSuccess: true, message: "message");
  }

  Future updateHistorian() async {}

  Future deleteHistorian() async {}

  Future<List<String>> getImages() async {
    http.Response res = await http.get(Uri.parse("$_baseUrl/gambar.php"));

    Response<String> data = Response.fromJson(
      json.decode(res.body),
      (value) => value,
    );

    if (!data.isSuccess) throw Exception(data.message);

    return data.data;
  }
}
