class Min_Dia_Danh {
   final id;
   final ten_dia_danh;

  Min_Dia_Danh(this.id, this.ten_dia_danh);

  Min_Dia_Danh.fromJson(Map<String, dynamic>  r)
   :id = r["id"],
   ten_dia_danh = r["ten_dia_danh"];
}