import 'package:app_du_lich/constant.dart';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/bai_viet_object.dart';
import 'package:app_du_lich/objects/dia_danh_object.dart';
import 'package:app_du_lich/provider/bai_viet_provider.dart';
import 'package:app_du_lich/provider/dia_danh_provider.dart';
import 'package:app_du_lich/provider/processed.dart';
import 'package:app_du_lich/screens/chi_tiet_dia_danh.dart';

import 'package:app_du_lich/screens/trang_ca_nhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'danh_sach_like.dart';

class TrangChiTietBaiViet extends StatefulWidget {
  final dynamic baiviet;
  const TrangChiTietBaiViet({Key? key, required this.baiviet})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return TrangChiTietBaiVietState(baiviet: baiviet);
  }
}

class TrangChiTietBaiVietState extends State<TrangChiTietBaiViet> {
  dynamic baiviet;
  TrangChiTietBaiVietState({required this.baiviet});
  List<dynamic> lstBaiViet = [];
  List<dynamic> diaDanh = [];

  void getDiaDanh(String diaDanhId) async {
    ApiResponse response = await DiaDanh(diaDanhId);
    if (response.error == null) {
      if (response.data != null) {
        if (mounted) {
          setState(() {});
          diaDanh = response.data! as List<dynamic>;
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('getDiaDanh trang chi tiết bài viết')));
    }
  }

//Lấy ds các bài viết về địa danh đang chia sẻ 7.2.2022 TranLinh
  void baiVietLienQuan(String diaDanhId) async {
    ApiResponse response =
        await getBaiVietDiaDanh(baiviet.dia_danh_id.toString());
    if (response.error == null) {
      setState(() {
        lstBaiViet = response.data as List<dynamic>;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lấy bài viết liên quan lỗi')));
    }
  }

  //Được gọi khi thực hiện like or dislike 7.2.2022 TranLinh
  void reloadBaiViet(String id) async {
    ApiResponse responseBaiViet = await getBaiViet(baiviet.id.toString());
    if (responseBaiViet.error == null) {
      setState(() {
        baiviet = responseBaiViet.data as dynamic;
        baiviet = baiviet[0];
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('reloadBaiViet')));
    }
  }

  //like or unlike
  void handleLike(int id) async {
    ApiResponse response = await likeOrUnlike(id);
    if (response.error == null) {
      reloadBaiViet(baiviet.id.toString());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('lỗi nút like')));
    }
  }

//dislike or undislike
  void handleDislike(int id) async {
    ApiResponse response = await dislikeOrUndislike(id);
    if (response.error == null) {
      reloadBaiViet(baiviet.id.toString());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi dislike')));
    }
  }

  @override
  void initState() {
    super.initState();
    getDiaDanh(baiviet.dia_danh_id.toString());
    baiVietLienQuan(baiviet.dia_danh_id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
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
                  '   ' + baiviet.user!.name.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                background: Stack(
                  children: [
                    Center(
                      child: Image.network(baseURL2 +
                          linkImage(baiviet.hinh_bai_viet!.img.toString())),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                                    backgroundImage: NetworkImage(baiviet
                                            .user!.img!
                                            .contains('storage')
                                        ? baseURL2 +
                                            linkImage(
                                                baiviet.user!.img.toString())
                                        : // Neu da co cap nhat ben stogare thi dung
                                        baseURL.substring(
                                                0, baseURL.length - 3) +
                                            baiviet.user!.img.toString()),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      baiviet.views_count.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.blue,
                                    )
                                  ],
                                )
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              //Tương tác
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.blue))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 1, right: 1),
                            child: TextButton(
                              //hien thi luot like
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LikePerson()));
                              },
                              child: Text(
                                baiviet.likes_count.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: IconButton(
                                //xu ly nut like
                                onPressed: () {
                                  setState(() {});
                                  handleLike(baiviet.id!);
                                },
                                icon: Icon(
                                  baiviet.like!
                                      ? Icons.thumb_up_alt
                                      : Icons.thumb_up_alt_outlined,
                                  color: Colors.blue,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 1, right: 10),
                            child: Text(baiviet.dislikes_count.toString(),
                                style: TextStyle(color: Colors.black)),
                          ),
                          IconButton(
                              //xu ly nut dislike
                              onPressed: () {
                                handleDislike(baiviet.id!);
                              },
                              icon: Icon(
                                baiviet.dislike!
                                    ? Icons.thumb_down
                                    : Icons.thumb_down_outlined,
                                color: Colors.blue,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //Noi dung bai viet
              Text(
                baiviet.noi_Dung,
                style: TextStyle(
                  fontSize: 18,
                ),
                softWrap: true,
              ),
              SizedBox(
                height: 20,
              ),

              //Đi đến địa danh
              Text(
                "Đi đến địa danh:",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
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
                                    builder: (context) => TrangChiTietDiaDanh(
                                        diaDanh: diaDanh.length == 0
                                            ? null
                                            : diaDanh[0])));
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(diaDanh.length == 0
                                ? loadingImage
                                : baseURL2 +
                                    linkImage(diaDanh[0].hinh.img.toString())),
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
                            child: Text(diaDanh.length == 0
                                ? 'Watting ...'
                                : diaDanh[0].ngay_Tao.toString()),
                          ),
                        ),
                      ],
                    )),
              ),
              //Hiển thị các bài viết về địa danh này
              SizedBox(
                height: 20,
              ),
              Text(
                "Bài viết liên quan",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.24,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: lstBaiViet.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, i) {
                      Bai_Viet bv = lstBaiViet[i] as Bai_Viet;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TrangChiTietBaiViet(baiviet: bv)));
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.36,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(baseURL2 +
                                  linkImage(bv.hinh_bai_viet!.img
                                      .toString())), //Hinh Anh bai viet
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
                                  bv.user!.name.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  bv.created_at.toString(),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
