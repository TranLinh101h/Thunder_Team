class Likes {
  final int id;
  // ignore: non_constant_identifier_names
  final int id_BaiViet;
  // ignore: non_constant_identifier_names
  final int id_User;

  Likes(this.id, this.id_BaiViet, this.id_User);

  Likes.formJson(Map<String, dynamic> r)
      : id = r['id'],
        id_BaiViet = r['id_BaiViet'],
        id_User = r['id_User'];
}
