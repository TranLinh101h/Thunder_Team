import 'package:app_du_lich/objects/hinh_diadiem_object.dart';

class Diem_Luu_Tru {
  int? id;
  int? loai_luu_tru_id;
  int? dia_danh_id;
  String? kinh_Do;
  String? vi_Do;
  String? ten_Diem;
  String? mo_Ta;
  String? sdt;
  Hinh_Dia_Diem? hinh;

  Diem_Luu_Tru(
      {this.id,
      this.loai_luu_tru_id,
      this.dia_danh_id,
      this.kinh_Do,
      this.vi_Do,
      this.ten_Diem,
      this.mo_Ta,
      this.sdt,
      this.hinh});

  factory Diem_Luu_Tru.fromJson(Map<String, dynamic> r) {
    return Diem_Luu_Tru(
        id: r['id'],
        loai_luu_tru_id: r['loai_luu_tru_id'],
        dia_danh_id: r['dia_danh_id'],
        kinh_Do: r['kinh_Do'],
        vi_Do: r['vi_Do'],
        ten_Diem: r['ten_Diem'],
        mo_Ta: r['mo_Ta'],
        sdt: r['sdt'],
        hinh: Hinh_Dia_Diem(
            diem_luu_tru_id: r['hinhdiadiem'][0]['diem_luu_tru_id'],
            img: r['hinhdiadiem'][0]['img']));
  }
}
