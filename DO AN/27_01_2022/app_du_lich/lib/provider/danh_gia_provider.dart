import 'dart:convert';

import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/danh_gia_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getDanhGia(String diaDanhId) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(diemdanhgiaURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'dia_danh_id': diaDanhId
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = Danh_Gia.fromJson(jsonDecode(response.body));
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

Future<ApiResponse> DanhGia(String diaDanhId, String danhGia) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(danhgiaURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'dia_danh_id': diaDanhId,
      'danh_gia': danhGia
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['msg'];
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
