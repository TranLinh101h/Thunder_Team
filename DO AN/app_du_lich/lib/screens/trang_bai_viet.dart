import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/bai_viet_object.dart';
import 'package:app_du_lich/provider/dia_danh_provider.dart';
import 'package:app_du_lich/provider/processed.dart';
import 'package:app_du_lich/screens/chi_tiet_baiviet.dart';
import 'package:app_du_lich/screens/chi_tiet_dia_danh.dart';
import 'package:app_du_lich/screens/danh_sach_like.dart';
import 'package:app_du_lich/screens/dia_danh_theo_mien.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_du_lich/provider/bai_viet_provider.dart';

import '../constant.dart';

class TrangBaiViet extends StatefulWidget {
  // Man update 23/01/2022
  const TrangBaiViet({Key? key}) : super(key: key);

  @override
  TrangBaiVietState createState() => TrangBaiVietState();
}

class TrangBaiVietState extends State<TrangBaiViet> {
  List<dynamic> diaDanh = [];
  List<dynamic> lstBaiViet = [];

  //Lấy địa danh theo id
  void _getDiaDanh(String id) async {
    ApiResponse response = await DiaDanh(id);
    if (response.error == null) {
      if (response.data != null) {
        if (mounted)
          setState(() {
            diaDanh = response.data! as List<dynamic>;
          });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lồi phần getDiaDanh trang bài viết')));
    }
  }

  void load() async {
    ApiResponse response = await getAllBaiViet();
    if (response.error == null) {
      if (response.data != null) {
        if (mounted)
          setState(() {
            lstBaiViet = response.data! as List<dynamic>;
          });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi phần Load trang bài viết')));
    }
  }

//like or unlike
  void handleLike(int id) async {
    ApiResponse response = await likeOrUnlike(id);
    if (response.error == null) {
      load();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi nút like')));
    }
  }

//dislike or undislike
  void handleDislike(int id) async {
    ApiResponse response = await dislikeOrUndislike(id);
    if (response.error == null) {
      load();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi nút dislike')));
    }
  }

//view
  void views(int id) async {
    ApiResponse response = await view(id);
    if (response.error == null) {
      load();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi view')));
    }
  }

  @override
  void initState() {
    super.initState();
    load();
    //_getDiaDanh('1');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> lstImage = [
      'images/img1.jpg',
      'images/img2.jpg',
      'images/img3.jpg',
      'images/img4.jpg',
    ];
    List<String> miens = ['Miền Bắc', 'Miền Trung', 'Miền Nam'];

    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.grey[350],
              expandedHeight: 200,
              floating: false,
              //  pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.24,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DiaDanhMien(mien: miens[index])));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width * 0.36,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(lstImage[index]),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.9)
                                  ],
                                  begin: Alignment.topCenter,
                                  stops: [0.5, 1],
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text(
                                    miens[index], //TEN MIEN
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      color: miens[index]
                                              .toLowerCase()
                                              .contains('b')
                                          ? Colors.red
                                          : miens[index]
                                                  .toLowerCase()
                                                  .contains('t')
                                              ? Colors.green
                                              : Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    softWrap: true,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Text(
                                        "view",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Sigmar'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
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
                      String _image = baseURL2 +
                          linkImage(bv.hinh_bai_viet!.img.toString());
                      String diaDanhId =
                          lstBaiViet[index].dia_danh_id.toString();
                      //  _getDiaDanh(diaDanhId); //Lay dia danh
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
                                  child: Text(bv.created_at
                                      .toString()
                                      .substring(0, 22)),
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
                                padding: EdgeInsets.all(5),
                                child: Image.network(_image)),
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
                                                          diaDanh: diaDanh
                                                                      .length ==
                                                                  0
                                                              ? null
                                                              : diaDanh[0])));
                                        },
                                        leading: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/ts2.png'),
                                        ),
                                        title: Text(
                                          diaDanh.length == 0
                                              ? 'Watting ...'
                                              : diaDanh[0].ten_dia_danh,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        subtitle: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            diaDanh.length == 0
                                                ? 'Watting ...'
                                                : diaDanh[0]
                                                    .ngay_Tao
                                                    .toString(),
                                          ),
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
                                            EdgeInsets.only(left: 1, right: 1),
                                        child: TextButton(
                                          //hien thi luot like
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LikePerson()));
                                          },
                                          child: Text(
                                            bv.likes_count.toString(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: IconButton(
                                            //xu ly nut like
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
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 1, right: 10),
                                        child: Text(
                                            bv.dislikes_count.toString(),
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ),
                                      IconButton(
                                          //xu ly nut dislike
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
                    })));
    //
  }
}
