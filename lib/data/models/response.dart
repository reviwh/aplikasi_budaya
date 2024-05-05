class Response<T> {
  final bool isSuccess;
  final String message;
  final List<T> data;

  const Response({
    required this.isSuccess,
    required this.message,
    this.data = const [],
  });

  factory Response.fromJsonWithoutData(
    Map<String, dynamic> json,
  ) =>
      Response(
        isSuccess: json["isSuccess"],
        message: json["message"],
      );

  factory Response.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) =>
      Response(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: json["data"] != null
            ? List<T>.from(json["data"].map((x) => fromJsonT(x)))
            : [],
      );
}

// To parse this JSON data, do
//
//     final modelListMahasiswa = modelListMahasiswaFromJson(jsonString);

// import 'dart:convert';

// ModelListMahasiswa modelListMahasiswaFromJson(String str) => ModelListMahasiswa.fromJson(json.decode(str));

// String modelListMahasiswaToJson(ModelListMahasiswa data) => json.encode(data.toJson());

// class ModelListMahasiswa {
//     bool isSuccess;
//     String message;
//     List<Datum> data;

//     ModelListMahasiswa({
//         this.isSuccess,
//         this.message,
//         this.data,
//     });

//     factory ModelListMahasiswa.fromJson(Map<String, dynamic> json) => ModelListMahasiswa(
//         isSuccess: json["isSuccess"],
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "isSuccess": isSuccess,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class Datum {
//     String idBerita;
//     String judulBerita;
//     String kontenBerita;
//     String gambarBerita;
//     DateTime created;
//     dynamic updated;

//     Datum({
//         this.idBerita,
//         this.judulBerita,
//         this.kontenBerita,
//         this.gambarBerita,
//         this.created,
//         this.updated,
//     });

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         idBerita: json["id_berita"],
//         judulBerita: json["judul_berita"],
//         kontenBerita: json["konten_berita"],
//         gambarBerita: json["gambar_berita"],
//         created: DateTime.parse(json["created"]),
//         updated: json["updated"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id_berita": idBerita,
//         "judul_berita": judulBerita,
//         "konten_berita": kontenBerita,
//         "gambar_berita": gambarBerita,
//         "created": created.toIso8601String(),
//         "updated": updated,
//     };
// }
