class Phan_Vung {
  final int id;
  final String ten_Vung;

  Phan_Vung(this.id, this.ten_Vung);

  Phan_Vung.fromjson(Map<String, dynamic> r)
      : id = r['id'],
        ten_Vung = r['ten_Vung'];
}
