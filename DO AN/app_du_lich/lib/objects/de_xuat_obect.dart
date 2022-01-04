class De_Xuat {
  final int id;
  final int id_User;
  final String ten_Diem;
  final String mo_Ta;
  final String img;

  De_Xuat(this.id, this.id_User, this.ten_Diem, this.mo_Ta, this.img);

  De_Xuat.formJson(Map<String, dynamic> r)
      : id = r['id'],
        id_User = r['id_User'],
        ten_Diem = r['ten_Diem'],
        mo_Ta = r['img'],
        img = r['img'];
}
