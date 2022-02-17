import 'dart:math';
import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/bai_viet_object.dart';
import 'package:app_du_lich/objects/danh_gia_object.dart';
import 'package:app_du_lich/objects/diem_luu_tru_object.dart';
import 'package:app_du_lich/objects/hinh_diadiem_object.dart';
import 'package:app_du_lich/objects/map_object.dart';
import 'package:app_du_lich/objects/min_dia_danh_object.dart';
import 'package:app_du_lich/provider/bai_viet_provider.dart';
import 'package:app_du_lich/provider/danh_gia_provider.dart';
import 'package:app_du_lich/provider/dia_danh_provider.dart';
import 'package:app_du_lich/provider/diem_luu_tru_provider.dart';
import 'package:app_du_lich/provider/processed.dart';
import 'package:app_du_lich/screens/chi_tiet_baiviet.dart';
import 'package:app_du_lich/screens/create_and_update/tao_bai_viet.dart';
import 'package:app_du_lich/screens/map.dart';
// import 'package:app_du_lich/screens/map.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../constant.dart';

class TrangChiTietDiaDanh extends StatefulWidget {
  final dynamic diaDanh;
  const TrangChiTietDiaDanh({Key? key, required this.diaDanh})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return TrangChiTietDiaDanhState(diaDanh: diaDanh);
  }
}

class TrangChiTietDiaDanhState extends State<TrangChiTietDiaDanh> {
  late final dynamic diaDanh;
  TrangChiTietDiaDanhState({required this.diaDanh});
  List<dynamic> lstLuuTru = [];
  List<dynamic> hinhDiaDanh = [];
  List<dynamic> lstBaiViet = [];
  late LatLng viTriDiaDanh;
  Danh_Gia _danhGia = Danh_Gia(rating: 0);
  late Min_Dia_Danh selectDiaDanh; // Man crreate 15/01/2022 : 12:10:20

  //Lấy giá trị rating 8/2/2022
  void getRating(String diaDanhId) async {
    ApiResponse response = await getDanhGia(diaDanhId);
    if (response.error == null) {
      if (mounted)
        setState(() {
          _danhGia = response.data as dynamic;
        });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lấy điểm đánh giá lỗi')));
    }
  }

  //Đánh giá cho địa danh 8/2/2022
  void Rate(String diaDanhId, String danhGia) async {
    ApiResponse response = await DanhGia(diaDanhId, danhGia);
    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cảm ơn bạn đã đánh giá cho chúng tôi!')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('đánh giá lỗi')));
    }
  }

//Lấy ds các bài viết về địa danh đang chia sẻ 7.2.2022 TranLinh
  void baiVietLienQuan(String diaDanhId) async {
    ApiResponse response = await getBaiVietDiaDanh(diaDanhId);
    if (response.error == null) {
      if (mounted)
        setState(() {
          lstBaiViet = response.data as List<dynamic>;
        });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lấy bài viết liên quan lỗi')));
    }
  }

  //Lấy ds điểm lưu trú của địa danh
  void load() async {
    ApiResponse response = await getDiemLuuTru(diaDanh.id);
    if (response.error == null) {
      if (response.data != null) {
        if (mounted)
          setState(() {
            lstLuuTru = response.data! as List<dynamic>;
          });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

//Lay danh sach hinh cho dia danh
  void _getHinhDiaDanh(String id) async {
    ApiResponse response = await getHinhDiaDanh(id);
    if (response.error == null) {
      if (mounted) {
        setState(() {
          hinhDiaDanh = response.data as List<dynamic>;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi phần Load hình địa danh')));
    }
  }

  @override
  void initState() {
    super.initState();
    // Man update 12:10:22
    load();
    getRating(diaDanh.id.toString()); // TranLinh: 8/2/2022
    baiVietLienQuan(diaDanh.id.toString()); // TranLinh: 1/2022
    _getHinhDiaDanh(diaDanh.id.toString());
    setState(() {
      viTriDiaDanh =
          LatLng(double.parse(diaDanh.kinh_Do), double.parse(diaDanh.vi_Do));
    });

    selectDiaDanh = Min_Dia_Danh(diaDanh.id, diaDanh.ten_dia_danh);
  }

  Widget hinhDD(String img) {
    return Image.network(
      img,
      fit: BoxFit.cover,
    );
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      child: hinhDiaDanh.length == 0
                          ? Image.asset('images/loading2.gif')
                          : ImageSlideshow(
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
                                for (Hinh_Dia_Diem hinh in hinhDiaDanh)
                                  // hinhDiaDanh.length ==0? NetworkImage(loadingImage):
                                  hinhDD(
                                      baseURL2 + linkImage(hinh.img.toString()))
                              ],

                              /// Called whenever the page in the center of the viewport changes.
                              onPageChanged: (value) {
                                // print('Page changed: $value');
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
                          stops: const [0.6, 1],
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            diaDanh.ten_dia_danh,
                            style: const TextStyle(
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
                                            builder: (context) => TaoBaiViet(
                                                selectDiaDanh: selectDiaDanh)));
                                  },
                                  icon: const Icon(
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
                                        icon: const Icon(
                                          Icons.image,
                                          color: Colors.blue,
                                        )),
                                    IconButton(
                                        tooltip: 'Vị trí',
                                        onPressed: () async {
                                          LatLng myLocation = LatLng(0, 0);
                                          RoadMap _roadMap = new RoadMap(
                                              distance: 0, times: 0, lat: []);

                                          // Gọi api từ gg lấy về vị trí
                                          Position position = await Geolocator
                                              .getCurrentPosition(
                                                  desiredAccuracy:
                                                      LocationAccuracy.high);
                                          myLocation.latitude =
                                              position.latitude;
                                          myLocation.longitude =
                                              position.longitude;
                                          //
                                          ApiResponse response = await getMap(
                                              keyMap,
                                              "${myLocation.longitude},${myLocation.latitude}",
                                              "${viTriDiaDanh.longitude},${viTriDiaDanh.latitude}");
                                          List<dynamic> roadMap =
                                              response.data as List<dynamic>;
                                          if (mounted) {
                                            setState(() {
                                              _roadMap = roadMap[0] as RoadMap;
                                            });
                                          }
                                          //
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MyMap(
                                                        diaDanh: viTriDiaDanh,
                                                        myLocation: myLocation,
                                                        roadMap: _roadMap,
                                                      )));
                                        },
                                        icon: const Icon(
                                          Icons.location_on,
                                          color: Colors.green,
                                        )),
                                    Row(
                                      children: [
                                        Text(
                                          diaDanh.share_count.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Icon(
                                          Icons.share,
                                          color: Colors.yellow,
                                        )
                                      ],
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
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              //Đánh giá bài viết
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.cyan[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.black)),
                child: Column(
                  children: [
                    Text(
                      'Đánh giá địa danh này:',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.green),
                    ),
                    RatingBar.builder(
                      initialRating: _danhGia.danh_gia.toDouble(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                        }
                        return Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                      },
                      onRatingUpdate: (rating) {
                        print(rating);
                        Rate(diaDanh.id.toString(), rating.toString());
                        getRating(diaDanh.id.toString());
                      },
                    ),
                    Text(
                      'Rating:  ${_danhGia.rating}/5.0',
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    )
                  ],
                ),
              ),
              //end rating
              SizedBox(height: 20),
              Text(
                diaDanh.ten_dia_danh,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                diaDanh.mo_Ta,
                style: const TextStyle(
                  fontSize: 18,
                ),
                softWrap: true,
              ),
              const SizedBox(
                height: 20,
              ),
              //hiển thị các điểm lưu trú của địa danh
              const Text(
                "Điểm lưu trú",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              lstLuuTru.length == 0
                  ? Center(
                      child: Text(
                        'Đang cập nhật ...',
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.builder(
                          itemCount:
                              lstLuuTru.length, //bổ xung list điểm lưu trú
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            Diem_Luu_Tru diem_luu_tru =
                                lstLuuTru[i] as Diem_Luu_Tru;
                            return Container(
                              margin: const EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width * 0.95,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: double.infinity,
                                    child: Image.network(
                                      //Hinh anh diem luu tru

                                      baseURL2 +
                                          linkImage(diem_luu_tru.hinh!.img
                                              .toString()),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        diem_luu_tru.ten_Diem.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Text(
                                        diem_luu_tru.mo_Ta
                                                .toString()
                                                .substring(0, 20) +
                                            '...',
                                        style: const TextStyle(fontSize: 18),
                                        softWrap: true,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              color: Colors.green),
                                          Text(
                                            'Liên hệ: ' +
                                                diem_luu_tru.sdt.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.fade,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
              const SizedBox(
                height: 20,
              ),
              //Hiển thị các bài viết về địa danh này
              const Text(
                "Bài viết liên quan",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
                child: lstBaiViet.length == 0
                    ? Center(
                        child: Text(
                          'Chưa có bài viết nào!',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      )
                    : ListView.builder(
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

// ignore: non_constant_identifier_names
Widget DiemLuuTru(BuildContext context, String image) {
  return Card(
    child: Container(
        height: MediaQuery.of(context).size.height * 0.34,
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.34,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
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
              const SizedBox(
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
