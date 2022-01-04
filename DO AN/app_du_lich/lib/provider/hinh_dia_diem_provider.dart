import 'package:http/http.dart' as http;
import 'package:app_du_lich/objects/hinh_diadiem_object.dart';
import 'dart:convert';

class HinhDiaDiemProvider {
  static List<Hinh_Dia_Diem> parseHinhDD(String reponseBody) {
    final parsed = jsonDecode(reponseBody).cast<Map<String, dynamic>>();

    return parsed.map<Hinh_Dia_Diem>((e) => Hinh_Dia_Diem.fromJson(e)).toList();
  }

  static Future<List<Hinh_Dia_Diem>> fecthHinhDDId(int id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/hinhdiadanh/$id'));

    return parseHinhDD(response.body);
  }
}
