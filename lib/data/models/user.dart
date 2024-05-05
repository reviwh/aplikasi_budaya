class User {
  String id;
  String username;
  String fullname;
  String nim;
  String nohp;
  String email;
  String address;

  User({
    required this.id,
    required this.username,
    required this.fullname,
    required this.nim,
    required this.nohp,
    required this.email,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id_user"],
      username: json["username"],
      fullname: json["fullname"],
      nim: json["nim"],
      nohp: json["nohp"],
      email: json["email"],
      address: json["alamat"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_user": id,
        "username": username,
        "fullname": fullname,
        "nim": nim,
        "nohp": nohp,
        "email": email,
        "alamat": address,
      };

  static User empty() => User(
        id: "",
        username: "",
        fullname: "",
        nim: "",
        nohp: "",
        email: "",
        address: "",
      );
}
