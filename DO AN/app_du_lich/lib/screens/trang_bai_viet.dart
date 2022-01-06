import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/bai_viet_object.dart';
import 'package:app_du_lich/screens/chi_tiet_dia_danh.dart';
import 'package:app_du_lich/screens/danh_sach_like.dart';
import 'package:app_du_lich/screens/trang_ca_nhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_du_lich/provider/bai_viet_provider.dart';

class TrangBaiViet extends StatefulWidget {
  @override
  TrangBaiVietState createState() => TrangBaiVietState();
}

class TrangBaiVietState extends State<TrangBaiViet> {
  List<dynamic> lstBaiViet = [];

  void load() async {
    ApiResponse response = await getAllBaiViet();
    if (response.error == null) {
      if (response.data != null) {
        setState(() {
          lstBaiViet = response.data! as List<dynamic>;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return lstBaiViet.length == 0
        ? Center(
            child: Text(
              'Chưa có bài viết nào!',
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
          )
        : Container(
            child: ListView.builder(
                itemCount: lstBaiViet.length,
                itemBuilder: (context, index) => Card(
                      color: Colors.white,
                      shadowColor: Colors.grey[600],
                      child: Column(
                        children: [
                          ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TrangCaNhan()));
                              },
                              leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                //Avatar
                                "images/fox.jpg",
                              )),
                              title: Text(
                                'Trần Linh',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              subtitle: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('24 phút'),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.clear),
                                tooltip: 'Ẩn bài viết này',
                              )),
                          // Content
                          Container(
                              width: double.infinity, //tràn hai bên
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Mùa đông',
                                  softWrap: true,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                          //Bài đc chia sẻ
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ))),
                            child: Card(
                                color: Colors.blue,
                                shadowColor: Colors.black,
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TrangChiTietDiaDanh(
                                                      diaDanh: null,
                                                    )));
                                      },
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/images/ts2.png'),
                                      ),
                                      title: Text(
                                        'Khu vực núi tuyết',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      subtitle: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('5 tháng'),
                                      ),
                                    ),
                                    Container(
                                        width: double.infinity, //tràn hai bên
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                              'Khu vực thắng cảnh đẹp tại Nhật Bản',
                                              softWrap: true,
                                              style: TextStyle(fontSize: 15)),
                                        )),
                                    Image.asset('images/img1.jpg')
                                  ],
                                )),
                          ),

                          //Tương tác
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LikePerson()));
                                        },
                                        child: Text(
                                          '15',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.thumb_up_alt_outlined,
                                          color: Colors.blue,
                                        )),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: Text('5',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.thumb_down_outlined,
                                          color: Colors.blue,
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text('15 '),
                                    Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )));
  }
}
