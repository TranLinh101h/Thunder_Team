// ignore: camel_case_types
class De_Xuat {
   int? id;
  // ignore: non_constant_identifier_names
   String? loai_dia_danh_id	;
  // ignore: non_constant_identifier_names
   int? user_id;
  // ignore: non_constant_identifier_names
   String? ten_Diem;
   // ignore: non_constant_identifier_names
  String? ten_Goi_Khac;
  // ignore: non_constant_identifier_names
   String? mo_Ta;
  // ignore: non_constant_identifier_names
   String? kinh_Do;
  // ignore: non_constant_identifier_names
   String? vi_Do;
   String? img;

  De_Xuat(this.id,this.loai_dia_danh_id, this.user_id, this.ten_Diem, this.ten_Goi_Khac ,
  this.mo_Ta,this.kinh_Do, this.vi_Do ,this.img);

  De_Xuat.formJson(Map<String, dynamic> r)
      : id = r['id'],
        loai_dia_danh_id = r['loai_dia_danh_id'],
        user_id = r['user_id'],
        ten_Diem = r['ten_Diem'],
        ten_Goi_Khac = r['ten_Goi_Khac'],
        mo_Ta = r['mo_Ta'],
        kinh_Do = r['kinh_Do'],
        vi_Do = r['vi_Do'],
        img = r['img'];


    // Do vận chuyển tài nguyên bằng class này ít quá nên khỏi chuyển thành mảng Json như mấy class khác - vậy là đủ sài rù !!
  }
  

