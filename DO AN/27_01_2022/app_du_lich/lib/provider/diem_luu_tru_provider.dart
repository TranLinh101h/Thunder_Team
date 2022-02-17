import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/diem_luu_tru_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:http/http.dart' as http;
 import 'dart:convert';

Future<ApiResponse> getDiemLuuTru(int id) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(diemluutruURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'dia_danh_id': id.toString()
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['diemluutru']
            .map((p) => Diem_Luu_Tru.fromJson(p))
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
