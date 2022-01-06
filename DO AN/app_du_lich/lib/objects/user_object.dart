class User {
  int? id;
  String? name;
  String? password;
  String? email;
  String? sdt;
  String? img;
  String? token;
  int? status_email;
  int? status_sdt;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.sdt,
    this.img,
    this.token,
    this.status_email,
    this.status_sdt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        email: json['user']['email'],
        password: json['user']['password'],
        sdt: json['user']['sdt'],
        img: json['user']['img'],
        token: json['token'],
        status_email: json['user']['status_email'],
        status_sdt: json['user']['status_sdt']);
  }
}
