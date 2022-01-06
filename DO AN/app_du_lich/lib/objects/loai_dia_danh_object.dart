class Loai_Dia_Danh {
  final int id;
  final String ten_Loai;

  Loai_Dia_Danh(this.id, this.ten_Loai);

  Loai_Dia_Danh.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        ten_Loai = r['ten_Loai'];
}
