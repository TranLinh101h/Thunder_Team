//Xử lý đường link ảnh do IP thường xuyên thay đổi
import 'package:app_du_lich/objects/api_response.dart';

import 'bai_viet_provider.dart';

String linkImage(String img) {
  int index = img.indexOf('storage');
  String _img = img.substring(index, img.length);
  return _img;
}
