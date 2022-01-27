class User {
  int? id;
  String? name;
  String? gioi_Tinh;
  String? password;
  String? email;
  String? sdt;
  String? img;
  String? token;
  // ignore: non_constant_identifier_names
  int? status_email;
  // ignore: non_constant_identifier_names
  int? status_sdt;

  User({
    this.id,
    this.name,
    this.gioi_Tinh,
    this.email,
    this.password,
    this.sdt,
    this.img,
    this.token,
    // ignore: non_constant_identifier_names
    this.status_email,
    // ignore: non_constant_identifier_names
    this.status_sdt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        gioi_Tinh: json['user']['gioi_Tinh'],
        email: json['user']['email'],
        password: json['user']['password'],
        sdt: json['user']['sdt'],
        img: json['user']['img'],
        token: json['token'],
        status_email: json['user']['status_email'],
        status_sdt: json['user']['status_sdt']);
  }
}
