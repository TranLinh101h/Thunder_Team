class Hinh_Bai_Viet {
  int? id;
  int? bai_viet_id;
  String? img;

  Hinh_Bai_Viet({this.id, this.bai_viet_id, this.img});

  factory Hinh_Bai_Viet.fromJson(Map<String, dynamic> r) {
    return Hinh_Bai_Viet(
        id: r['id'], bai_viet_id: r['bai_viet_id'], img: r['img']);
  }
}
