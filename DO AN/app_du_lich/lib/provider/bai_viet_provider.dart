import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/min_dia_danh_object.dart';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:app_du_lich/objects/bai_viet_object.dart';
import 'dart:convert';

//Tran Linh
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

Future<ApiResponse> getAllBaiVietUser(int user_id) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(baivietuserURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'user_id': user_id.toString()
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['baiviets']
            .map((p) => Bai_Viet.fromJson(p))
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

//7.2.2022 TranLinh
Future<ApiResponse> getBaiViet(String id) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(getbaivietURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'id': id
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['baiviets']
            .map((p) => Bai_Viet.fromJson(p))
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

Future<ApiResponse> getBaiVietDiaDanh(String diaDanhId) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(baivietdiadanhURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'dia_danh_id': diaDanhId
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['baiviets']
            .map((p) => Bai_Viet.fromJson(p))
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
// // encoded image sang mã base64 để lưu trữ
// String? getStringImage(File? file) {
//   if(file == null) return null;
//   return base64Encode(file.readAsBytesSync());
// }

// ignore: slash_for_doc_comments
/**
 *  author : Mẩn sợ ma
 *  Update: : 06/01/2022 20:31:10
 *  fix img tao bai viet and url 404
 *  create sua bai viet 
 *  07/01/2022 21:30:22 create getNameDiaDanh & parsePost
 */
Future<ApiResponse> taoHinhBaiViet(int idBaiViet, String image) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(hinhanhBaiVietURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'bai_viet_id': idBaiViet.toString(),
      'img': image
    });
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

Future<ApiResponse> getIdBaiViet() async {
  // Dùng để lấy tên địa danh cho screen chọn địa danh
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

Future<ApiResponse> getNameDiaDanh() async {
  // Dùng để lấy tên địa danh cho screen chọn địa danh
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

Future<ApiResponse> taoBaiViet(String body, String idDiaDanh) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(baivietURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'dia_danh_id': idDiaDanh.toString(),
      'noi_Dung': body
    }); // Nếu mà người ta không có nhu cầu up hình thì lấy phần nội dung thoy
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

//TranLinh: update 9/2/2022
Future<ApiResponse> suaBaiViet(int idBaiViet, String noiDung) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.put(Uri.parse(suabaivietURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'id': idBaiViet,
      'noi_Dung': noiDung
    }); // Nếu mà người ta không có nhu cầu up hình thì lấy phần nội dung thoy
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

//TranLinh: update 9/2/2022
Future<ApiResponse> xoaBaiViet(int idBaiViet) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse(xoabaivietURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'id': idBaiViet.toString()
    }); // Nếu mà người ta không có nhu cầu up hình thì lấy phần nội dung thoy
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

//Tran Linh

//like and unlike
Future<ApiResponse> likeOrUnlike(int id) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse('$actionBaiVietURL/$id/likes'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
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

//dislike and undislike
Future<ApiResponse> dislikeOrUndislike(int id) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse('$actionBaiVietURL/$id/dislikes'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
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

//make view on post
Future<ApiResponse> view(int id) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse('$actionBaiVietURL/$id/views'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
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
