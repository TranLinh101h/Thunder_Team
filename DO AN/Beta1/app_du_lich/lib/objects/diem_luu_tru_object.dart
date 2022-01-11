// ignore: camel_case_types
class Diem_Luu_Tru {
  final int id;
  // ignore: non_constant_identifier_names
  final int id_Loai;
  // ignore: non_constant_identifier_names
  final int id_DD;
  // ignore: non_constant_identifier_names
  final String kinh_Do;
  // ignore: non_constant_identifier_names
  final String vi_Do;
  // ignore: non_constant_identifier_names
  final String ten_Diem;
  // ignore: non_constant_identifier_names
  final String mo_Ta;

  Diem_Luu_Tru(this.id, this.id_Loai, this.id_DD, this.kinh_Do, this.vi_Do,
      this.ten_Diem, this.mo_Ta);

  Diem_Luu_Tru.formJson(Map<String, dynamic> r)
      : id = r['id'],
        id_Loai = r['id_Loai'],
        id_DD = r['id_DD'],
        kinh_Do = r['kinh_Do'],
        vi_Do = r['vi_Do'],
        ten_Diem = r['ten_Diem'],
        mo_Ta = r['mo_Ta'];
}
