//Xử lý đường link ảnh do IP thường xuyên thay đổi
import 'dart:convert';

import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/loai_dia_danh_object.dart';
import 'package:app_du_lich/objects/map_object.dart';
import 'package:http/http.dart' as http;
import 'bai_viet_provider.dart';

String linkImage(String img) {
  int index = img.indexOf('storage');
  String _img = img.substring(index, img.length);
  return _img;
}

/*class UserProvider {
  static List<UserObject> parseUsers(String reponseBody) {
    final parsed = jsonDecode(reponseBody).cast<Map<String, dynamic>>();
 
    return parsed.map<UserObject>((e) => UserObject.fromJson(e)).toList();
  }
*/
Future<ApiResponse> getMap(String key, String start, String end) async {
  ApiResponse apiResponse = ApiResponse();
  final response = await http.get(Uri.parse(
      'https://api.openrouteservice.org/v2/directions/driving-car?api_key=${key}&start=${start}&end=${end}'));
  apiResponse.data = jsonDecode(response.body)['features']
      .map((p) => RoadMap.fromJson(p))
      .toList();
  apiResponse.data as List<dynamic>;
  return apiResponse;
}

 /* static Future<UserObject> fecthUserById(int id) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/$id'));
    return UserObject.fromJson(jsonDecode(response.body));
  }
}
*/