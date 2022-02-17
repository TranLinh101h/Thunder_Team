class Danh_Gia {
  int? id;
  int? user_id;
  int? dia_danh_id;
  double? rating;
  int danh_gia;

  Danh_Gia(
      {this.id,
      this.user_id,
      this.dia_danh_id,
      this.rating,
      this.danh_gia = 0});

  factory Danh_Gia.fromJson(Map<String, dynamic> r) {
    return Danh_Gia(
        rating: double.parse(r['rating'].toString()),
        id: r['danhgia']['id'],
        user_id: r['danhgia']['user_id'],
        dia_danh_id: r['danhgia']['dia_danh_id'],
        danh_gia: r['danhgia']['danh_gia']);
  }
}
