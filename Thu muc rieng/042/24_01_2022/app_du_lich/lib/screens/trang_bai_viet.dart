import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/bai_viet_object.dart';
import 'package:app_du_lich/screens/chi_tiet_baiviet.dart';
import 'package:app_du_lich/screens/chi_tiet_dia_danh.dart';
import 'package:app_du_lich/screens/danh_sach_like.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_du_lich/provider/bai_viet_provider.dart';

class TrangBaiViet extends StatefulWidget { // Man update 23/01/2022
  const TrangBaiViet({Key? key}) : super(key: key);

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
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return lstBaiViet.length == 0
        ? Center(
            child: Text(
              'Ch??a c?? b??i vi???t n??o!',
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
                              tooltip: '???n b??i vi???t n??y',
                            )),
                        // Content
                        Container(
                            width: double.infinity, //tr??n hai b??n
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                bv.noi_Dung.toString() + '...',
                                softWrap: true,
                                style: TextStyle(fontSize: 15),
                              ),
                            )),
                        //B??i ??c chia s???
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
                                      'Khu v???c n??i tuy???t',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    subtitle: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('5 th??ng'),
                                    ),
                                  ),
                                  Container(
                                      width: double.infinity, //tr??n hai b??n
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                            'Khu v???c th???ng c???nh ?????p t???i Nh???t B???n',
                                            softWrap: true,
                                            style: TextStyle(fontSize: 15)),
                                      )),
                                  Image.asset('images/img1.jpg')
                                ],
                              )),
                        ),

                        //T????ng t??c
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
