import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:app_du_lich/objects/dia_danh_object.dart';
import 'dart:convert';

//Lấy ds địa danh theo loại
Future<ApiResponse> getDiaDanhTheoMien(String mien) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(diadanhtheomienURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'mien_id': mien
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['diadanhs']
            .map((p) => Dia_Danh.fromJson(p))
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

//Lấy địa danh theo id
Future<ApiResponse> DiaDanh(String id) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(getdiadanhURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'dia_danh_id': id
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['diadanhs']
            .map((p) => Dia_Danh.fromJson(p))
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

Future<ApiResponse> getAllDiaDanh() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(diadanhURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['diadanhs']
            .map((p) => Dia_Danh.fromJson(p))
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

//Lấy ds địa danh hot
Future<ApiResponse> getDiaDanhHot() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(diadanhhotURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['diadanhs']
            .map((p) => Dia_Danh.fromJson(p))
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

//Tìm kiếm theo tên địa danh
Future<ApiResponse> timKiem(String diaDanh) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(timkiemURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'tenDiaDanh': diaDanh
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['diadanhs']
            .map((p) => Dia_Danh.fromJson(p))
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
