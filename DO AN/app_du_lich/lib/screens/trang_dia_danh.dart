import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/provider/dia_danh_provider.dart';
import 'package:app_du_lich/provider/hinh_dia_diem_provider.dart';
import 'package:app_du_lich/screens/chi_tiet_dia_danh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class TrangDiaDanh extends StatefulWidget {
  @override
  TrangDiaDanhState createState() => TrangDiaDanhState();
}

Widget _DiaDanh(
    BuildContext context, String image, dynamic diadanh, String img) {
  return Card(
    elevation: 2.0,
    margin: EdgeInsets.only(bottom: 20),
    child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TrangChiTietDiaDanh(
                          diaDanh: diadanh,
                        )));
          },
          leading: SizedBox(
            width: 120,
            height: 130,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          //Image.network(image),
          title: Text(
            diadanh.ten_dia_danh,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontFamily: 'Sigmar'),
          ),
          subtitle: Column(
            children: [
              Text(
                diadanh.mo_Ta.substring(0, 40) + ' ...',
                maxLines: 2,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(Icons.date_range),
                  Text(
                    diadanh.ngay_Tao == null ? '' : diadanh.ngay_Tao.toString(),
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          ),
        )
        /*Row(
        children: [
          Container(
              width: 200,
              height: 90,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.network(img), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(8.0))),
          SizedBox(
            width: 5,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrangChiTietDiaDanh()));
                },
                child: Text(
                  diadanh.ten_dia_danh,
                  style: TextStyle(
                      fontSize: 15, color: Colors.black, fontFamily: 'Sigmar'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  diadanh.mo_Ta.substring(0, 40) + ' ...',
                  maxLines: 2,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(Icons.date_range),
                  Text(
                    diadanh.ngay_Tao == null ? '' : diadanh.ngay_Tao.toString(),
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          ))
        ],
      ),*/
        ),
  );
}

class TrangDiaDanhState extends State<TrangDiaDanh>
    with SingleTickerProviderStateMixin {
  List<dynamic> lstDiaDanh = [];
  List<dynamic> lstHinh = [];
  void load() async {
    ApiResponse response = await getAllDiaDanh();
    if (response.error == null) {
      if (response.data != null) {
        setState(() {
          lstDiaDanh = response.data! as List<dynamic>;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }

    ApiResponse responseImg = await getAllHinhDiaDiem();
    if (responseImg.error == null) {
      if (responseImg.data != null) {
        setState(() {
          lstHinh = responseImg.data! as List<dynamic>;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${responseImg.error}')));
    }
  }

  //Danh sách các loại địa danh
  List<Tab> _tapList = [
    Tab(
      child: Text('Phượt',
          style: TextStyle(
              fontSize: 15,
              fontFamily: 'Josefin',
              fontWeight: FontWeight.bold)),
    ),
    Tab(
      child: Text('Nghỉ dưỡng',
          style: TextStyle(
              fontSize: 15,
              fontFamily: 'Josefin',
              fontWeight: FontWeight.bold)),
    ),
    Tab(
      child: Text(
        'Dã ngoại',
        style: TextStyle(
            fontSize: 15, fontFamily: 'Josefin', fontWeight: FontWeight.bold),
      ),
    ),
    Tab(
      child: Text(
        'Cắm trại',
        style: TextStyle(
            fontSize: 15, fontFamily: 'Josefin', fontWeight: FontWeight.bold),
      ),
    ),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tapList.length, vsync: this);
    load();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: TabBar(
              indicatorColor: Colors.white,
              isScrollable: true,
              controller: _tabController,
              tabs: _tapList,
              labelColor: Colors.white,
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                child: VungDiaDanh('assets/images/ms.png', lstDiaDanh),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: VungDiaDanh('assets/images/mts1.png', lstDiaDanh),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: VungDiaDanh('assets/images/mts2.png', lstDiaDanh),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: VungDiaDanh('assets/images/mts3.png', lstDiaDanh),
              ),
            )
          ],
        ));
    ;
  }

  //Hiển thị các địa danh theo từng loại địa danh
//Biến truyền vào sẽ là danh sách địa danh theo loại
  Widget VungDiaDanh(String image, List<dynamic> lstDiaDanh) {
    List<String> lstImage = [
      'images/img1.jpg',
      'images/img2.jpg',
      'images/img3.jpg',
      'images/img4.jpg',
    ];
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.grey[350],
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.24,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrangChiTietDiaDanh(
                                          diaDanh: null,
                                        )));
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
                                    'Thung lũng tuyết',
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    softWrap: true,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("15 lượt chia sẻ",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 15)),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Text(
                                        "HOT",
                                        style: TextStyle(
                                            color: Colors.red,
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
        body: Container(
          child: ListView.builder(
            itemCount: lstDiaDanh.length,
            itemBuilder: (context, index) => _DiaDanh(context, image,
                lstDiaDanh[index], getHinh(lstDiaDanh[index].id)),
          ),
        ));
  }

  String getHinh(int diaDanhId) {
    for (dynamic hinh in lstHinh) {
      if (hinh.dia_danh_id == diaDanhId) {
        return hinh.img.toString();
      }
    }
    return 'https://images.search.yahoo.com/images/view;_ylt=Awr9LtYyyNVhKxkAo0KJzbkF;_ylu=c2VjA3NyBHNsawNpbWcEb2lkAzFmYTdjODIyNmYzNjVkYmRmNzY3NDNlYzNiYTllZTc4BGdwb3MDMjMEaXQDYmluZw--?back=https%3A%2F%2Fimages.search.yahoo.com%2Fsearch%2Fimages%3Fp%3Dno%2Bimage%26type%3DE210US91215G0%26fr%3Dmcafee%26fr2%3Dpiv-web%26tab%3Dorganic%26ri%3D23&w=800&h=450&imgurl=images.puella-magi.net%2Fthumb%2F2%2F27%2FNo_Image_Wide.svg%2F800px-No_Image_Wide.svg.png%3F20110202071158&rurl=https%3A%2F%2Fwiki.puella-magi.net%2FFile%3ANo_Image_Wide.svg&size=13.3KB&p=no+image&oid=1fa7c8226f365dbdf76743ec3ba9ee78&fr2=piv-web&fr=mcafee&tt=File%3ANo+Image+Wide.svg+-+Puella+Magi+Wiki&b=0&ni=21&no=23&ts=&tab=organic&sigr=5aA6ZtcDI8lM&sigb=XQMmKPw_O59C&sigi=F6RsEgX4LOD8&sigt=kHhMsDq68A.u&.crumb=EQx0synzduS&fr=mcafee&fr2=piv-web&type=E210US91215G0';
  }
}
