import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/hinh_diadiem_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<ApiResponse> getAllHinhDiaDiem() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(hinhdiadiemURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['hinhdiadanh']
            .map((p) => Hinh_Dia_Diem.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        final errors = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = 'ngoai le';
  }
  return apiResponse;
}
