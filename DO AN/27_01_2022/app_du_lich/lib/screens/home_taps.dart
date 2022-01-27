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
import 'package:circular_menu/circular_menu.dart'; // Man create 26/01/2022
import 'package:convex_bottom_bar/convex_bottom_bar.dart'; // Man create 26/01/2022

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
    int selectedPages = 0; // Man create 25/01/2022 - set vi tri mac dinh cua page
    final _pageOption = [TrangBaiViet(), TrangDiaDanh(), TrangCaNhan()];

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
                MaterialPageRoute(builder: (context) => const LoginPage()),
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
  void initState() { // Man update 25/01/2022
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
      home: Scaffold(
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
              child: _loading ? const CircleAvatar( // Man update 26/01/2022 | fix er img 
                  backgroundImage: AssetImage(
                //Avatar
                "images/fox.jpg",
              )) : CircleAvatar(
                backgroundImage: NetworkImage(
                  user!.img!.contains('storage') ? user!.img.toString()  : // Neu da co cap nhat ben stogare thi dung 
                  baseURL.substring(0,baseURL.length-3)+user!.img.toString()), // do dart khong ho tro cat quay lui giong php nen phai dung cach nay
              )  ,
            ),
            centerTitle: true,
            title: SizedBox( // Man update 25/01/2022 | Tùy biến theo kích thước màn hình người dùng
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/earth.svg',
                        height: 28,
                        width: 28,
                      ),
                    const  SizedBox(width: 3),
                      const Text(
                        "TRAVEL APP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
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
          ),
          body: Center(
            child: _pageOption[selectedPages] 
          ),
          bottomNavigationBar: ConvexAppBar(
            items: const [
              TabItem(icon:Icons.home, title: 'Home'),
              TabItem(icon:Icons.travel_explore, title: 'Travel'),
              TabItem(icon:Icons.person, title: 'Person'),
            ],
            initialActiveIndex: selectedPages,
            onTap: (int index) {
                setState(() {
                  selectedPages = index;
                });
            }
          ),
          endDrawer: Drawer( // Man update 26/01/2022
            child: ListView(
              children: [ 
               DrawerHeader(
                  child: _loading ? const CircleAvatar(
                      backgroundImage: AssetImage(
                    //Avatar
                    "images/fox.jpg",
                  )) : CircleAvatar(
                backgroundImage: NetworkImage(
                  user!.img!.contains('storage') ? user!.img.toString()  : // Neu da co cap nhat ben stogare thi dung 
                  baseURL.substring(0,baseURL.length-3)+user!.img.toString()), // do dart khong ho tro cat quay lui giong php nen phai dung cach nay
              )  ,
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
                  onTap: () async{ // Man update 25/01/2022
                  final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>const DoiMatKhau()));
                    if(result != null)
                    {
                      _showSnackBar(result+'\n\n');
                    }
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
                                  builder: (context) =>const LoginPage()),
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
                      // ignore: avoid_print
                      print(result);
                      _showSnackBar(result+'\n\n');
                    }
                  }),
              ])),
    );
  }
}
