import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/user_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:app_du_lich/screens/chi_tiet_dia_danh.dart';
import 'package:app_du_lich/screens/create_and_update/chinh_sua_thong_tin.dart';
import 'package:app_du_lich/screens/create_and_update/doi_mat_khau.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/home_screen.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black,
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  user.name.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                background: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      child: Image.asset(
                        //background
                        'images/img3.jpg',
                        fit: BoxFit.cover,
                      ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Title name phần chữ lớn
                          Text(
                            user.name.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: "Sigmar"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 45,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      //Avatar
                                      "images/fox.jpg",
                                    ),
                                  ),
                                ),
                                Text(
                                  "0 Bài chia sẻ",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    //Mở cài đặt
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, top: 27),
                          child: IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CaiDat()));
                            },
                          ),
                        ))
                  ],
                ),
              ),
            )
          ];
        },
        body: Container(
            child: ListView.builder(
                itemCount: 5, //Khi code chức năng sẻ bổ xung lstBaiViet
                itemBuilder: (context, index) => Card(
                      //Bài viết
                      color: Colors.white,
                      shadowColor: Colors.grey[600],
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                                backgroundImage: AssetImage(
                              //Avatar
                              "images/fox.jpg",
                            )),
                            title: Text('Trần Linh',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('24 phút'),
                            ),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_horiz),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    child: ListTile(
                                  leading: Icon(
                                    Icons.update,
                                    color: Colors.cyan,
                                  ),
                                  title: Text('Sửa bài viết'),
                                )),
                                PopupMenuItem(
                                    child: ListTile(
                                  leading: Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
                                  title: Text('Xóa bài viết'),
                                ))
                              ],
                            ),
                          ),
                          // Content
                          Container(
                              width: double.infinity, //tràn hai bên
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Mùa đông',
                                  softWrap: true,
                                ),
                              )),
                          Image.asset('images/img3.jpg'),
                          //Bài đc chia sẻ
                          Container(
                            margin: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    //Hinh anh diem luu tru
                                    child: Image.asset(
                                      'images/img1.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Text(
                                        'description',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              color: Colors.green),
                                          Text(
                                            'Location',
                                            maxLines: 2,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
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
                                        child: Text('15',
                                            style:
                                                TextStyle(color: Colors.black)),
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
                                          EdgeInsets.only(left: 10, right: 10),
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
                    ))),
      ),
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
