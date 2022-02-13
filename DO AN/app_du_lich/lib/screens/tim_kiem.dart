import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/dia_danh_object.dart';
import 'package:app_du_lich/provider/dia_danh_provider.dart';
import 'package:app_du_lich/screens/chi_tiet_dia_danh.dart';
import 'package:app_du_lich/screens/trang_ca_nhan.dart';
import 'package:flutter/material.dart';

class TimKiem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimKiemState();
  }
}

class TimKiemState extends State<TimKiem> {
  TextEditingController name = TextEditingController();
  List<dynamic> lstDiaDanh = [];
  List<String> lstImage = [
    'images/img1.jpg',
    'images/img2.jpg',
    'images/img3.jpg',
    'images/img4.jpg',
  ];
  void timDiaDanh(String diaDanh) async {
    ApiResponse response = await timKiem(diaDanh);
    if (response.error == null) {
      if (mounted) {
        setState(() {
          lstDiaDanh = response.data as List<dynamic>;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi tìm kiếm địa danh')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: TextField(
                  onSubmitted: (String value) {
                    timDiaDanh(name.text);
                  },
                  controller: name,
                  decoration: InputDecoration(
                    prefix: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: " Nhập địa danh",
                    hintStyle: TextStyle(color: Colors.white),
                    //    suffixStyle: TextStyle(color: Colors.white)
                  ),
                ),
              ),
            ],
          )),
      body: lstDiaDanh.length == 0
          ? Center(
              child: Text(
                'Không tìm thấy kết quả cho từ khóa: ${name.text}',
                softWrap: true,
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            )
          : Container(
              margin: EdgeInsets.all(5),
              child: ListView.builder(
                  itemCount: lstDiaDanh.length,
                  itemBuilder: (context, index) {
                    Dia_Danh diaDanh = lstDiaDanh[index];
                    return Card(
                      child: ListTile(
                        title: Text(diaDanh.ten_dia_danh.toString()),
                        subtitle: Text(
                          diaDanh.ten_Goi_Khac == null
                              ? ''
                              : 'Tên gọi khác: ${diaDanh.ten_Goi_Khac}',
                          maxLines: 1,
                        ),
                        leading: SizedBox(
                          width: 100,
                          height: 120,
                          child: Image.asset(lstImage[index]),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrangChiTietDiaDanh(
                                        diaDanh: diaDanh,
                                      )));
                        },
                      ),
                    );
                  }),
            ),
    );
  }
}
