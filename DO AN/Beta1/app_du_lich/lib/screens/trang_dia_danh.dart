import 'package:app_du_lich/screens/chi_tiet_dia_danh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrangDiaDanh extends StatefulWidget {
  @override
  TrangDiaDanhState createState() => TrangDiaDanhState();
}

Widget _DiaDanh(BuildContext context, String image) {
  return Card(
    elevation: 2.0,
    margin: EdgeInsets.only(bottom: 20),
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
              width: 200,
              height: 90,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover),
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
                  'Title',
                  style: TextStyle(
                      fontSize: 18, color: Colors.black, fontFamily: 'Sigmar'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Content',
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
                    '14/12/2021',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    ),
  );
}

class TrangDiaDanhState extends State<TrangDiaDanh>
    with SingleTickerProviderStateMixin {
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
                child: VungDiaDanh('assets/images/ms.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: VungDiaDanh('assets/images/mts1.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: VungDiaDanh('assets/images/mts2.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: VungDiaDanh('assets/images/mts3.png'),
              ),
            )
          ],
        ));
    ;
  }
}

//Hiển thị các địa danh theo từng loại địa danh
//Biến truyền vào sẽ là danh sách địa danh theo loại
Widget VungDiaDanh(String image) {
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
                                  builder: (context) => TrangChiTietDiaDanh()));
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
          itemCount: 10,
          itemBuilder: (context, index) => _DiaDanh(context, image),
        ),
      ));
}
