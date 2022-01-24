import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/min_dia_danh_object.dart';
import 'package:app_du_lich/objects/user_object.dart';
import 'package:app_du_lich/provider/user_provider.dart';
import 'package:app_du_lich/screens/create_and_update/de_xuat_dia_danh.dart';
import 'package:app_du_lich/screens/create_and_update/tao_bai_viet.dart';
import 'package:app_du_lich/screens/tim_kiem.dart';
import 'package:app_du_lich/screens/trang_bai_viet.dart';
import 'package:app_du_lich/screens/trang_ca_nhan.dart';
import 'package:app_du_lich/screens/trang_dia_danh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constant.dart';
import 'create_and_update/chinh_sua_thong_tin.dart';
import 'create_and_update/doi_mat_khau.dart';
import 'dang_nhap_dang_ky/login.dart';
import 'trang_ca_nhan.dart';
import 'package:circular_menu/circular_menu.dart'; // Man create

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
    late TabController _tabController;
    Min_Dia_Danh selectDiaDanh = Min_Dia_Danh('1', 'home');  // Man create 15/01/2022 : 22:10:23
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();  // Khoa chung // Man update 23/01/2022
    User? user; // man update 23/01/2022
    bool _loading = true;  // man update 23/01/2022


void getInfo() async { // Man update 23/10/2022
    ApiResponse response = await getUser();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        _loading = !_loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        _loading = !_loading;
      });
    }
  }

// ignore: unused_element
_showSnackBar(String content) { // Man update 23/01/2022
  print('show');
  final snackBar = SnackBar(
    content: Text(content),
    duration: const Duration(seconds : 3),
    backgroundColor: Colors.green ,
    );
  // ignore: deprecated_member_use
  _scaffoldkey.currentState!.showSnackBar(snackBar);
} 

  @override
  void initState() { // Man update
    super.initState();
    getInfo();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTap);
  }

  @override
  void dispose() {
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
            key: _scaffoldkey, // Man update 23/01/2022
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.blue,
                leading: FlatButton(
                  height: 50,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TrangCaNhan()));
                  },
                  child: _loading ? const CircleAvatar(
                      backgroundImage: AssetImage(
                    //Avatar
                    "images/fox.jpg",
                  )) : CircleAvatar(
                    backgroundImage: NetworkImage(user!.img.toString()),
                  )  ,
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
                      const  SizedBox(width: 3),
                        const Text(
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
                        icon:const Icon(Icons.search, color: Colors.white)),
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
                    const DrawerHeader(
                      child: CircleAvatar(
                          backgroundImage: AssetImage(
                        //Avatar
                        "images/fox.jpg",
                      )),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                      title:const Text("Trang cá nhân"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrangCaNhan()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      title: const Text("Chỉnh sửa thông tin cá nhân"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>const ChinhSuaThongTin()));
                      },
                    ),
                    ListTile(
                      leading:const Icon(
                        Icons.lock,
                        color: Colors.orange,
                      ),
                      title:const Text("Đổi mật khẩu"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>const DoiMatKhau()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title:const Text("Đăng xuất"),
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
              floatingActionButton: CircularMenu(
                  // Man Update
                  alignment: Alignment.bottomRight,
                  radius: 80,
                  items: [
                    CircularMenuItem(
                        icon: Icons.add,
                        onTap: () {
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaoBaiViet(selectDiaDanh: selectDiaDanh )));
                      }),
                    CircularMenuItem(
                        icon: Icons.offline_share_rounded,
                        onTap: () async{
                        final result = await  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DeXuatDiaDanh()));
                        if(result != null)
                        {
                          print(result);

                          _showSnackBar(result);
                        }
                      }),
                  ]))),
    );
  }
}
