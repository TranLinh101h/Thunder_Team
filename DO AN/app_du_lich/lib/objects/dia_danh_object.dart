class Dia_Danh {
  int? id;
  String? ten_dia_danh;
  int? loai_dia_danh_id;
  int? mien_id;
  String? ten_Goi_Khac;
  String? mo_Ta;
  DateTime? ngay_Tao;
  String? kinh_Do;
  String? vi_Do;
  int? phan_vung_id;
  int? hot;
  int? share_count;

  Dia_Danh(
      {this.id,
      this.ten_dia_danh,
      this.loai_dia_danh_id,
      this.phan_vung_id,
      this.mien_id,
      this.ten_Goi_Khac,
      this.mo_Ta,
      this.ngay_Tao,
      this.kinh_Do,
      this.vi_Do,
      this.hot,
      this.share_count});

  factory Dia_Danh.fromJson(Map<String, dynamic> r) {
    return Dia_Danh(
        id: r['id'],
        ten_dia_danh: r['ten_dia_danh'],
        loai_dia_danh_id: r['loai_dia_danh_id'],
        phan_vung_id: r['phan_vung_id'],
        mien_id: r['mien_id'],
        ten_Goi_Khac: r['ten_Goi_Khac'],
        mo_Ta: r['mo_Ta'],
        ngay_Tao: r['created_at'],
        kinh_Do: r['kinh_Do'],
        vi_Do: r['vi_Do'],
        hot: r['hot'],
        share_count: r['baiviets_count']);
  }
}
