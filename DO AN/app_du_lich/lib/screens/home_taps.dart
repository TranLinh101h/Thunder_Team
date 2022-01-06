import 'package:app_du_lich/provider/user_provider.dart';
import 'package:app_du_lich/screens/dang_nhap_dang_ky/home_screen.dart';
import 'package:app_du_lich/screens/tim_kiem.dart';
import 'package:app_du_lich/screens/trang_bai_viet.dart';
import 'package:app_du_lich/screens/trang_ca_nhan.dart';
import 'package:app_du_lich/screens/trang_dia_danh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'create_and_update/chinh_sua_thong_tin.dart';
import 'create_and_update/de_xuat_dia_danh.dart';
import 'create_and_update/doi_mat_khau.dart';
import 'dang_nhap_dang_ky/login.dart';
import 'trang_ca_nhan.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTap);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Du Lịch',
      home: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.blue,
                leading: FlatButton(
                  height: 50,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TrangCaNhan()));
                  },
                  child: CircleAvatar(
                      backgroundImage: AssetImage(
                    //Avatar
                    "images/fox.jpg",
                  )),
                ),
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/earth.svg',
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(width: 3),
                        Text(
                          "TRAVEL APP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontFamily: "Sigmar",
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TimKiem()));
                        },
                        icon: Icon(Icons.search, color: Colors.white)),
                  ],
                ),
              ),
              bottomNavigationBar: TabBar(
                indicatorColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                controller: _tabController,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.house_outlined,
                      color: _tabController.index == 0
                          ? Colors.blue
                          : Colors.blue[200],
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.travel_explore_outlined,
                      color: _tabController.index == 1
                          ? Colors.blue
                          : Colors.blue[200],
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person_outline,
                      color: _tabController.index == 2
                          ? Colors.blue
                          : Colors.blue[200],
                    ),
                  ),
                ],
              ),
              body: Center(
                child: TabBarView(
                  controller: _tabController,
                  children: [TrangBaiViet(), TrangDiaDanh(), TrangCaNhan()],
                ),
              ),
              endDrawer: Drawer(
                child: ListView(
                  children: [
                    DrawerHeader(
                      child: CircleAvatar(
                          backgroundImage: AssetImage(
                        //Avatar
                        "images/fox.jpg",
                      )),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                      title: Text("Trang cá nhân"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrangCaNhan()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      title: Text("Chỉnh sửa thông tin cá nhân"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChinhSuaThongTin()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.lock,
                        color: Colors.orange,
                      ),
                      title: Text("Đổi mật khẩu"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoiMatKhau()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title: Text("Đăng xuất"),
                      onTap: () {
                        logout().then((value) => {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false)
                            });
                      },
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DeXuatDiaDanh()));
                },
                child: SvgPicture.asset(
                  'assets/images/star.svg',
                  height: 50,
                  width: 50,
                ),
                tooltip: 'Đề xuất 1 địa danh',
                backgroundColor: Colors.white,
              ))),
    );
  }
}
