// import 'dart:io'; // // Cho phép sử dụng các phương thức hỗ trợ liên quan đến tệp

import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/min_dia_danh_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:app_du_lich/objects/bai_viet_object.dart';
import 'dart:convert';

Future<ApiResponse> getAllBaiViet() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baivietURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['baiviets']
            .map((p) => Bai_Viet.fromJson(p))
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

// // encoded image sang mã base64 để lưu trữ
// String? getStringImage(File? file) {
//   if(file == null) return null;
//   return base64Encode(file.readAsBytesSync());
// }

// ignore: slash_for_doc_comments
/**
 *  author : Mẩn hecker
 *  Update: : 06/01/2022 20:31:10
 *  fix img tao bai viet and url 404
 *  create sua bai viet 
 *  07/01/2022 21:30:22 create getNameDiaDanh & parsePost
 */
  Future<ApiResponse> taoHinhBaiViet(int idBaiViet,String image) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post( 
      Uri.parse(hinhanhBaiVietURL),
      headers: {
        'Accept': 'application/json', 
        'Authorization': 'Bearer $token'
        },body: {
          'bai_viet_id' : idBaiViet.toString(),
          'img' : image
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


Future<ApiResponse> getIdBaiViet() async { // Dùng để lấy tên địa danh cho screen chọn địa danh
  ApiResponse apiResponse = ApiResponse();

    try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(idBaiViethURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['idBaiViet'];
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

Future<ApiResponse> getNameDiaDanh() async { // Dùng để lấy tên địa danh cho screen chọn địa danh
  ApiResponse apiResponse = ApiResponse();

    try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(nameDiaDanhURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['namediadanhs']
            .map((p) => Min_Dia_Danh.fromJson(p))
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

Future<ApiResponse> taoBaiViet(String body, int idDiaDanh) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse(baivietURL),
      headers: {
        'Accept': 'application/json', 
        'Authorization': 'Bearer $token'
        },body: {
          'dia_danh_id' : idDiaDanh.toString(),
          'noi_Dung' : body
        }

    );// Nếu mà người ta không có nhu cầu up hình thì lấy phần nội dung thoy
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

Future<ApiResponse> suaBaiViet(int idBaiViet, String body) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.put(
      Uri.parse('$baivietURL/$idBaiViet'),
      headers: {
        'Accept': 'application/json', 
        'Authorization': 'Bearer $token'
        },body: {
          'noi_Dung' : body
        }
    
    );// Nếu mà người ta không có nhu cầu up hình thì lấy phần nội dung thoy
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
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

Future<ApiResponse> xoaBaiViet(int idBaiViet) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('$baivietURL/$idBaiViet'),
      headers: {
        'Accept': 'application/json', 
        'Authorization': 'Bearer $token'
        },
    
    );// Nếu mà người ta không có nhu cầu up hình thì lấy phần nội dung thoy
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
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

