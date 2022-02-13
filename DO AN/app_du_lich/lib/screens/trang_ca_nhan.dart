import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/bai_viet_object.dart';
import 'package:app_du_lich/objects/user_object.dart';
import 'package:app_du_lich/provider/bai_viet_provider.dart';
import 'package:app_du_lich/provider/dia_danh_provider.dart';
import 'package:app_du_lich/provider/processed.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:app_du_lich/screens/chi_tiet_dia_danh.dart';
import 'package:app_du_lich/screens/create_and_update/chinh_sua_thong_tin.dart';
import 'package:app_du_lich/screens/create_and_update/doi_mat_khau.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/home_screen.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
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
        if (mounted)
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
      loadBaiViet();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

//dislike or undislike
  void handleDislike(int id) async {
    ApiResponse response = await dislikeOrUndislike(id);
    if (response.error == null) {
      loadBaiViet();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

//view
  void views(int id) async {
    ApiResponse response = await view(id);
    if (response.error == null) {
      loadBaiViet();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

//Lấy địa danh theo id
  void _getDiaDanh(String id, List<dynamic> diaDanh) async {
    ApiResponse response = await DiaDanh(id);
    if (response.error == null) {
      if (response.data != null) {
        if (mounted) setState(() {});
        diaDanh = response.data! as List<dynamic>;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lồi phần getDiaDanh trang bài viết')));
    }
  }

//Xóa bài viết
  void _xoaBaiViet(int idBaiViet) async {
    ApiResponse response = await xoaBaiViet(idBaiViet);
    if (response.error == null) {
      loadBaiViet();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Xóa không thành công!')));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
    loadBaiViet();
  }

  Widget _MenuItem(int idBaiViet) {
    return PopupMenuButton(
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) => [
              PopupMenuItem(
                  child: ListTile(
                leading: Icon(
                  Icons.edit_outlined,
                  color: Colors.blue,
                ),
                title: Text("Sửa bài viết"),
                onTap: () {},
              )),
              PopupMenuItem(
                  child: ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                title: Text("Xóa bài viết"),
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Bạn có chắc muốn xóa bài viết này?"),
                          content: Text("Vui lòng xác nhận xóa "),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Hủy")),
                            TextButton(
                                onPressed: () async {
                                  _xoaBaiViet(idBaiViet);
                                  Navigator.pop(context);
                                },
                                child: Text("Xóa"))
                          ],
                        );
                      });
                },
              )),
            ]);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        //  Bai_Viet baiviet = baiviet;
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '   ' + user.name.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              background: Stack(
                children: [
                  Center(
                    child: Image.network(user.img != null
                        ? user.img!.contains('storage')
                            ? baseURL2 + linkImage(user.img.toString())
                            : // Neu da co cap nhat ben stogare thi dung
                            baseURL.substring(0, baseURL.length - 3) +
                                user.img.toString()
                        : loadingImage),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                        begin: Alignment.topCenter,
                        stops: [0.6, 1],
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FlatButton(
                                height: 50,
                                onPressed: () {
                                  /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TrangCaNhan()));*/
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(user.img != null
                                      ? user.img!.contains('storage')
                                          ? baseURL2 +
                                              linkImage(user.img.toString())
                                          : // Neu da co cap nhat ben stogare thi dung
                                          baseURL.substring(
                                                  0, baseURL.length - 3) +
                                              user.img.toString()
                                      : loadingImage),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ];
      },
      body: lstBaiViet.length == 0
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
                    List<dynamic> diaDanh = [];
                    //_getDiaDanh(bv.dia_danh_id.toString(), diaDanh);

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
                                        builder: (context) =>
                                            TrangChiTietBaiViet(
                                              baiviet: bv,
                                            )));
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(bv.user!.img!
                                        .contains('storage')
                                    ? baseURL2 +
                                        linkImage(bv.user!.img.toString())
                                    : // Neu da co cap nhat ben stogare thi dung
                                    baseURL.substring(0, baseURL.length - 3) +
                                        bv.user!.img.toString()),
                              ),
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
                              trailing: _MenuItem(bv.id!)),
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
                              child: Image.network(baseURL2 +
                                  linkImage(bv.hinh_bai_viet!.img.toString()))),
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
                                        backgroundImage: NetworkImage(baseURL2 +
                                            linkImage(bv.hinh_bai_viet!.img
                                                .toString())),
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
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: Text(bv.dislikes_count.toString(),
                                          style:
                                              TextStyle(color: Colors.black)),
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
                  })),
    );
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
