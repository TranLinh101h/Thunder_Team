class Hinh_Dia_Diem {
  int? id;
  int? dia_danh_id;
  int? diem_luu_tru_id;
  String? img;

  Hinh_Dia_Diem({this.id, this.dia_danh_id, this.diem_luu_tru_id, this.img});

  factory Hinh_Dia_Diem.fromJson(Map<String, dynamic> r) {
    return Hinh_Dia_Diem(
        id: r['id'],
        dia_danh_id: r['dia_danh_id'],
        diem_luu_tru_id: r['diem_luu_tru_id'],
        img: r['img']);
  }
}
