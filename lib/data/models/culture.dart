class Culture {
  String id;
  String title;
  String content;
  String image;
  DateTime created;
  DateTime? updated;

  Culture({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.created,
    this.updated,
  });

  factory Culture.fromJson(Map<String, dynamic> json) => Culture(
        id: json["id_berita"],
        title: json["judul_berita"],
        content: json["konten_berita"],
        image: json["gambar_berita"],
        created: DateTime.parse(json["created"]),
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
      );
}
