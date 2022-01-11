import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<ApiResponse> taoDeXuat(String idLoai, String tenDiem, String tenGoiKhac, String moTa, String kinhDo, String viDo,String? img) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse(deXuatURL),
      headers: {
        'Accept': 'application/json', 
        'Authorization': 'Bearer $token'
        },body: img != null ? {
          'loai_dia_danh_id' : idLoai,
          'ten_Diem' : tenDiem,
          'ten_Goi_Khac' : tenGoiKhac,
          'mo_Ta' : moTa,
          'kinh_Do' : kinhDo,
          'vi_Do' : viDo,
          'img' : img
        } : {
           'loai_dia_danh_id' : idLoai,
          'ten_Diem' : tenDiem,
          'ten_Goi_Khac' : tenGoiKhac,
          'mo_Ta' : moTa,
          'kinh_Do' : kinhDo,
          'vi_Do' : viDo,
        }
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        // ignore: unused_local_variable
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = 'Lỗi bất định';
  }
  
  
  return apiResponse;
}