import 'package:app_du_lich/objects/loai_dia_danh_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/api_response.dart';

Future<ApiResponse> getLoaiDiaDanh() async {
  // Dùng để lấy tên địa danh cho screen chọn địa danh
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(idLoaiDiaDanhURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['loaidiadanhs']
            .map((p) => Loai_Dia_Danh.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        // ignore: unused_local_variable
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
