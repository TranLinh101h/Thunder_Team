// ignore: camel_case_types
class Loai_Dia_Danh {
  final int id;
  // ignore: non_constant_identifier_names
  final String ten_Loai;

  Loai_Dia_Danh(this.id, this.ten_Loai);

  Loai_Dia_Danh.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        ten_Loai = r['ten_Loai'];
}
