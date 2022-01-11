// ignore: camel_case_types
class Hinh_Dia_Diem {
  final int id;
  // ignore: non_constant_identifier_names
  final int id_DD;
  // ignore: non_constant_identifier_names
  final int id_DLT;
  final String img;

  Hinh_Dia_Diem(this.id, this.id_DD, this.id_DLT, this.img);

  Hinh_Dia_Diem.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        id_DD = r['id_DD'],
        id_DLT = r['id_DLT'],
        img = r['img'];
}
