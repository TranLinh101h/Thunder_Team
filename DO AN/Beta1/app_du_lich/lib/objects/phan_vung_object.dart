// ignore: camel_case_types
class Phan_Vung {
  final int id;
  // ignore: non_constant_identifier_names
  final String ten_Vung;

  Phan_Vung(this.id, this.ten_Vung);

  Phan_Vung.fromjson(Map<String, dynamic> r)
      : id = r['id'],
        ten_Vung = r['ten_Vung'];
}
