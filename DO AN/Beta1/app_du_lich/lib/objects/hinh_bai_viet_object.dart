// ignore: camel_case_types
class Hinh_Bai_Viet {
  final int id;
  // ignore: non_constant_identifier_names
  final int id_BaiViet;
  final String img;

  Hinh_Bai_Viet(this.id, this.id_BaiViet, this.img);

  Hinh_Bai_Viet.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        id_BaiViet = r['id_BaiViet'],
        img = r['img'];
}
