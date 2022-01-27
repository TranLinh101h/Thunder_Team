import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/bai_viet_object.dart';
import 'package:app_du_lich/objects/user_object.dart';
import 'package:app_du_lich/provider/bai_viet_provider.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:app_du_lich/screens/chi_tiet_dia_danh.dart';
import 'package:app_du_lich/screens/create_and_update/chinh_sua_thong_tin.dart';
import 'package:app_du_lich/screens/create_and_update/doi_mat_khau.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/home_screen.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chi_tiet_baiviet.dart';
import 'danh_sach_like.dart';

class TrangCaNhan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TrangCaNhanState();
  }
}

//final int index;
// DetailsScreen({this.index});
class TrangCaNhanState extends State<TrangCaNhan> {
  User user = User();
  List<dynamic> lstBaiViet = [];

  void loadBaiViet() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiResponse response =
        await getAllBaiVietUser(int.parse(pref.getInt('userId').toString()));
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

  Future<void> load() async {
    ApiResponse response = await getUser();
    if (response.error == null) {
      if (response.data != null) {
        setState(() {
          user = response.data! as User;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

//like or unlike
  void handleLike(int id) async {
    ApiResponse response = await likeOrUnlike(id);
    if (response.error == null) {
      load();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

//dislike or undislike
  void handleDislike(int id) async {
    ApiResponse response = await dislikeOrUndislike(id);
    if (response.error == null) {
      load();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

//view
  void views(int id) async {
    ApiResponse response = await view(id);
    if (response.error == null) {
      load();
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
    loadBaiViet();
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
                itemBuilder: (context, index) {
                  Bai_Viet bv = lstBaiViet[index];
                  DateTime time = DateTime.now();

                  return Card(
                    color: Colors.white,
                    shadowColor: Colors.grey[600],
                    child: Column(
                      children: [
                        ListTile(
                            onTap: () {
                              views(bv.id!);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TrangChiTietBaiViet(
                                            baiviet: bv,
                                          )));
                            },
                            leading: CircleAvatar(
                                backgroundImage: AssetImage(
                              //Avatar
                              "images/fox.jpg",
                            )),
                            title: Text(
                              bv.user!.name.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            subtitle: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  bv.created_at.toString().substring(0, 22)),
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
                                bv.noi_Dung.toString() + '...',
                                softWrap: true,
                                style: TextStyle(fontSize: 15),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.network(
                                bv.hinh_bai_viet!.img.toString())),
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
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LikePerson()));
                                      },
                                      child: Text(
                                        bv.likes_count.toString(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {});
                                        handleLike(bv.id!);
                                      },
                                      icon: Icon(
                                        bv.like!
                                            ? Icons.thumb_up_alt
                                            : Icons.thumb_up_alt_outlined,
                                        color: Colors.blue,
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: Text(bv.dislikes_count.toString(),
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        handleDislike(bv.id!);
                                      },
                                      icon: Icon(
                                        bv.dislike!
                                            ? Icons.thumb_down
                                            : Icons.thumb_down_outlined,
                                        color: Colors.blue,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(bv.views_count.toString()),
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
                  );
                }));
  }
}

class CaiDat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Align(
        alignment: Alignment.center,
        child: Text(
          'Cài đặt',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      )),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  leading: Icon(
                    Icons.info,
                    color: Colors.green,
                  ),
                  title: Text('Thông tin cá nhân')),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                      bottom: BorderSide(width: 0.5, color: Colors.grey))),
            ),
            Container(
              child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChinhSuaThongTin()));
                  },
                  leading: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  title: Text('Chỉnh sửa thông tin cá nhân')),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                      bottom: BorderSide(width: 0.5, color: Colors.grey))),
            ),
            Container(
              child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DoiMatKhau()));
                  },
                  leading: Icon(
                    Icons.lock,
                    color: Colors.orange,
                  ),
                  title: Text('Đổi mật khẩu')),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                      bottom: BorderSide(width: 0.5, color: Colors.grey))),
            ),
            Container(
              child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManHinhChinh()));
                  },
                  leading: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: Text('Đăng xuất')),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                      bottom: BorderSide(width: 0.5, color: Colors.grey))),
            ),
          ],
        ),
      ),
    );
  }
}
