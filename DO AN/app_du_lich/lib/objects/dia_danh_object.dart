class Dia_Danh {
  int? id;
  String? ten_dd;
  int? id_Loai;
  int? id_Mien;
  String? ten_Goi_Khac;
  String? mo_Ta;
  DateTime? ngay_Tao;
  String? kinh_Do;
  String? vi_Do;
  int? id_Phan_Vung;
  bool? hot;
  int? share_count;

  Dia_Danh(
      {this.id,
      this.ten_dd,
      this.id_Loai,
      this.id_Phan_Vung,
      this.ten_Goi_Khac,
      this.mo_Ta,
      this.ngay_Tao,
      this.kinh_Do,
      this.vi_Do,
      this.hot,
      this.share_count});

  factory Dia_Danh.fromJson(Map<String, dynamic> r) {
    return Dia_Danh(
        id: r['diadanhs']['id'],
        ten_dd: r['diadanhs']['ten_dd'],
        id_Loai: r['diadanhs']['id_Loai'],
        ten_Goi_Khac: r['diadanhs']['ten_Goi_Khac'],
        mo_Ta: r['diadanhs']['mo_Ta'],
        ngay_Tao: r['diadanhs']['ngay_Tao'],
        kinh_Do: r['diadanhs']['kinh_Do'],
        vi_Do: r['diadanhs']['vi_Do'],
        id_Phan_Vung: r['diadanhs']['id_Phan_Vung'],
        hot: r['diadanhs']['hot'],
        share_count: r['diadanhs']['baiviets_count']);
  }
}
