import 'package:http/http.dart' as http;
import 'package:app_du_lich/objects/dia_danh_object.dart';
import 'dart:convert';

class DiaDanhProvider {
  static List<Dia_Danh> parseDiaDanh(String reponseBody) {
    final parsed = jsonDecode(reponseBody).cast<Map<String, dynamic>>();

    return parsed.map<Dia_Danh>((e) => Dia_Danh.fromJson(e)).toList();
  }

  static Future<List<Dia_Danh>> fecthDiaDanhId(int id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/diadanh/$id'));

    return parseDiaDanh(response.body);
  }
}
