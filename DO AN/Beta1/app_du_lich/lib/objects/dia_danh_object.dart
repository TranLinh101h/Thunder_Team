// ignore: camel_case_types
class Dia_Danh {
  int? id;
  // ignore: non_constant_identifier_names
  String? ten_dia_danh; // Map Update 08/01/2022
  // ignore: non_constant_identifier_names
  int? id_Loai;
  // ignore: non_constant_identifier_names
  int? id_Mien;
  // ignore: non_constant_identifier_names
  String? ten_Goi_Khac;
  // ignore: non_constant_identifier_names
  String? mo_Ta;
  // ignore: non_constant_identifier_names
  DateTime? ngay_Tao;
  // ignore: non_constant_identifier_names
  String? kinh_Do;
  // ignore: non_constant_identifier_names
  String? vi_Do;
  // ignore: non_constant_identifier_names
  int? id_Phan_Vung;
  bool? hot;
  // ignore: non_constant_identifier_names
  int? share_count;

  Dia_Danh(
      {this.id,
      // ignore: non_constant_identifier_names
      this.ten_dia_danh, // Man Update 08/01/2022
      // ignore: non_constant_identifier_names
      this.id_Loai,
      // ignore: non_constant_identifier_names
      this.id_Phan_Vung,
      // ignore: non_constant_identifier_names
      this.ten_Goi_Khac,
      // ignore: non_constant_identifier_names
      this.mo_Ta,
      // ignore: non_constant_identifier_names
      this.ngay_Tao,
      // ignore: non_constant_identifier_names
      this.kinh_Do,
      // ignore: non_constant_identifier_names
      this.vi_Do,
      this.hot,
      // ignore: non_constant_identifier_names
      this.share_count});

  factory Dia_Danh.fromJson(Map<String, dynamic> r) {
    return Dia_Danh(
        id: r['diadanhs']['id'],
        ten_dia_danh: r['diadanhs']['ten_dia_danh'], // Man Update 08/01/2022
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
