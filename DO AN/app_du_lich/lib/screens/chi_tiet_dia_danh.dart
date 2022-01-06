import 'dart:math';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/dia_danh_object.dart';
import 'package:app_du_lich/objects/diem_luu_tru_object.dart';
import 'package:app_du_lich/provider/diem_luu_tru_provider.dart';
import 'package:app_du_lich/screens/create_and_update/tao_bai_viet.dart';
import 'package:app_du_lich/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class TrangChiTietDiaDanh extends StatefulWidget {
  final dynamic diaDanh;
  TrangChiTietDiaDanh({Key? key, required this.diaDanh}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return TrangChiTietDiaDanhState(diaDanh: diaDanh);
  }
}

//final int index;
// DetailsScreen({this.index});
Widget DiemLuuTru(BuildContext context, String image) {
  return Card(
    child: Container(
        height: MediaQuery.of(context).size.height * 0.34,
        width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.34,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Editor Choice"),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'title',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
  );
}

class TrangChiTietDiaDanhState extends State<TrangChiTietDiaDanh> {
  late final dynamic diaDanh;
  TrangChiTietDiaDanhState({required this.diaDanh});
  List<dynamic> lstLuuTru = [];

  List<String> lstImage = [
    'images/img1.jpg',
    'images/img2.jpg',
    'images/img3.jpg',
    'images/img4.jpg',
  ];

  void load() async {
    ApiResponse response = await getDiemLuuTru(diaDanh.id);
    if (response.error == null) {
      if (response.data != null) {
        setState(() {
          lstLuuTru = response.data! as List<dynamic>;
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
                  "Vùng núi",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                background: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      child: ImageSlideshow(
                        width: double.infinity,

                        height: 250,

                        initialPage: 0,

                        /// The color to paint the indicator.
                        indicatorColor: Colors.blue,

                        /// The color to paint behind th indicator.
                        indicatorBackgroundColor: Colors.grey,

                        /// The widgets to display in the [ImageSlideshow].
                        /// Add the sample image file into the images folder
                        children: [
                          Image.asset(
                            'images/img3.jpg',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'images/img1.jpg',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'images/img2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ],

                        /// Called whenever the page in the center of the viewport changes.
                        onPageChanged: (value) {
                          print('Page changed: $value');
                        },

                        /// Auto scroll interval.
                        autoPlayInterval: 3000,

                        /// Loops back to first slide.
                        isLoop: true,
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
                          Text(
                            diaDanh.ten_dia_danh,
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
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TaoBaiViet()));
                                  },
                                  icon: Icon(
                                    Icons.open_in_new,
                                    color: Colors.grey,
                                  ),
                                  tooltip: 'Chia sẻ địa danh này',
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        tooltip: 'Xem hình ảnh',
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.image,
                                          color: Colors.blue,
                                        )),
                                    IconButton(
                                        tooltip: 'Vị trí',
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.location_on,
                                          color: Colors.green,
                                        )),
                                    Text(
                                      diaDanh.share_count.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
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
              Text(
                diaDanh.ten_dia_danh,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                diaDanh.mo_Ta,
                style: TextStyle(
                  fontSize: 18,
                ),
                softWrap: true,
              ),
              SizedBox(
                height: 20,
              ),
              //hiển thị các điểm lưu trú của địa danh
              Text(
                "Điểm lưu trú",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  itemCount: lstLuuTru.length, //bổ xung list điểm lưu trú
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(width: 1)),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            //Hinh anh diem luu tru
                            child: Image.asset(
                              lstImage[0],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lstLuuTru[i].ten_Diem.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                lstLuuTru[i].mo_Ta.toString().substring(0, 20),
                                style: TextStyle(fontSize: 18),
                                softWrap: true,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.green),
                                  Text(
                                    'Liên hệ: ' + lstLuuTru[i].sdt.toString(),
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
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //Hiển thị các bài viết về địa danh này
              Text(
                "Bài viết liên quan",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
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
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.36,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(lstImage[i]),
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
                              'title',
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
                              "3 hours ago",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
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
      ),
    );
  }
}
