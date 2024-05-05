class Historian {
  final String id;
  final String name;
  final String image;
  final String dateOfBirth;
  final String from;
  final String gender;
  final String description;

  const Historian({
    required this.id,
    required this.name,
    required this.image,
    required this.dateOfBirth,
    required this.from,
    required this.gender,
    required this.description,
  });

  factory Historian.fromJson(Map<String, dynamic> json) => Historian(
        id: json["id"],
        name: json["nama"],
        image: json["foto"],
        dateOfBirth: json["tgl_lahir"],
        from: json["asal"],
        gender: json["jenis_kelamin"],
        description: json["deskripsi"],
      );
}
