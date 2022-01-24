import 'package:app_du_lich/objects/hinh_bai_viet_object.dart';
import 'package:app_du_lich/objects/user_object.dart';

class Bai_Viet {
  int? id;
  int? user_id;
  int? dia_danh_id;
  String? noi_Dung;
  String? created_at;
  int? checked;
  int? likes_count;
  int? views_count;
  int? dislikes_count;
  User? user;
  bool? like;
  bool? dislike;
  Hinh_Bai_Viet? hinh_bai_viet;

  Bai_Viet(
      {this.id,
      this.user_id,
      this.dia_danh_id,
      this.noi_Dung,
      this.created_at,
      this.checked,
      this.likes_count,
      this.views_count,
      this.dislikes_count,
      this.user,
      this.like,
      this.dislike,
      this.hinh_bai_viet});

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
        like: r['likes'].length > 0,
        dislike: r['dislikes'].length > 0,
        hinh_bai_viet: Hinh_Bai_Viet(img: r['hinhbaiviet'][0]['img']),
        user: User(
            id: r['user']['id'],
            name: r['user']['name'],
            img: r['user']['img']));
  }
}
