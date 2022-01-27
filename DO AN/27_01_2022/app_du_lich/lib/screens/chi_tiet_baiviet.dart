import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/bai_viet_object.dart';

import 'package:app_du_lich/screens/trang_ca_nhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class TrangChiTietBaiViet extends StatefulWidget {
  final dynamic baiviet;
  const TrangChiTietBaiViet({Key? key, required this.baiviet}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return TrangChiTietBaiVietState(baiviet: baiviet);
  }
}

class TrangChiTietBaiVietState extends State<TrangChiTietBaiViet> {
  late final dynamic baiviet;
  TrangChiTietBaiVietState({required this.baiviet});
  List<dynamic> lstLuuTru = [];

  List<String> lstImage = [
    'images/img1.jpg',
    'images/img2.jpg',
    'images/img3.jpg',
    'images/img4.jpg',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          Bai_Viet bv = baiviet;
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black,
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  '   ' + bv.user!.name.toString(),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TrangCaNhan()));
                                  },
                                  child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                    //Avatar
                                    "images/fox.jpg",
                                  )),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      bv.views_count.toString(),
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
