import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/provider/user_provider.dart'; // Lấy token 
import 'package:http/http.dart' as http;
import 'package:app_du_lich/objects/hinh_bai_viet_object.dart';
import 'dart:convert';
import '../constant.dart';

class HinhBaiVietProvider {
  static List<Hinh_Bai_Viet> parseHinhBaiViet(String reponseBody) {
    final parsed = jsonDecode(reponseBody).cast<Map<String, dynamic>>();

    return parsed.map<Hinh_Bai_Viet>((e) => Hinh_Bai_Viet.fromJson(e)).toList();
  }

  static Future<List<Hinh_Bai_Viet>> fecthHinhBVId(int id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/hinhbaiviet/$id'));

    return parseHinhBaiViet(response.body);
  }


// Man create 09/01/2022 | method taoHinhBaiViet dùng để gửi ảnh người ta chọn bên phần viết bài lên server 

}
