import 'package:app_du_lich/objects/user_object.dart';

// ignore: camel_case_types
class Bai_Viet {
  int? id;
  // ignore: non_constant_identifier_names
  int? user_id;
  // ignore: non_constant_identifier_names
  int? dia_danh_id;
  // ignore: non_constant_identifier_names
  String? noi_Dung;
  // ignore: non_constant_identifier_names
  DateTime? created_at;
  int? checked;
  // ignore: non_constant_identifier_names
  int? likes_count;
  // ignore: non_constant_identifier_names
  int? views_count;
  // ignore: non_constant_identifier_names
  int? dislikes_count;
  User? user;

  Bai_Viet(
      {this.id,
      // ignore: non_constant_identifier_names
      this.user_id,
      // ignore: non_constant_identifier_names
      this.dia_danh_id,
      // ignore: non_constant_identifier_names
      this.noi_Dung,
      // ignore: non_constant_identifier_names
      this.created_at,
      this.checked,
      // ignore: non_constant_identifier_names
      this.likes_count,
      // ignore: non_constant_identifier_names
      this.views_count,
      // ignore: non_constant_identifier_names
      this.dislikes_count,
      this.user});

  factory Bai_Viet.fromJson(Map<String, dynamic> r) {
    return Bai_Viet(
        id: r['id'],
        user_id: r['is_User'],
        dia_danh_id: r['dia_danh_id'],
        noi_Dung: r['noi_Dung'],
        created_at: r['created_at'],
        checked: r['checked'],
        likes_count: r['likes_count'],
        views_count: r['views_count'],
        dislikes_count: r['dislikes_count'],
        user: User(
            id: r['user']['id'],
            name: r['user']['name'],
            img: r['user']['img']));
  }

}
