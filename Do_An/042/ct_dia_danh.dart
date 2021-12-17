// Đây là màn hình chi tiết địa danh

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';// Thư viện dùng để chạy danh sách hình

class ChiTietDiaDanh extends StatefulWidget{
  const ChiTietDiaDanh({Key? key}) : super(key: key);

  @override
   ChiTietDiaDanhState createState() => ChiTietDiaDanhState();
}

class ChiTietDiaDanhState extends State<ChiTietDiaDanh> {
  final List<String> imageList = [
    "https://i.imgur.com/zuG2bGQ.jpg"
    "https://i.imgur.com/ovr0NAF.jpg"
    "https://i.imgur.com/pSHXfu5.jpg"
  ]; // Danh sách img lấy từ server - khi có data thật thay thế sau

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container( // Resize picture
            height: MediaQuery.of(context).size.height / 2 + 50, // Lấy tổng chiều cao màn hình /2
            decoration:const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/places/GirlHaLong.jpg')
                 )
               ),
              ),
        // Phía dưới là Content 
              Positioned(
                top: 20,
                right: 10,
                left: 10,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:const [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.push_pin_outlined,
                    color: Colors.black,
                  ), )
              ], )
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3)  ,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset:const Offset(0,3),
                    )
                  ]),
                  transform: Matrix4.translationValues(0, 20, 0),
                  child:const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30,
                  ),
                ) ,
              ))
            ],
          )
        , Padding(  
            padding:const EdgeInsets.symmetric(horizontal: 20),
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Hạ Khong Bay',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'All travelers to Vietnam confirm that “Halong Bay is a great destination that just has to be on your itinerary when visiting Vietnam”. You just cannot find another place on Earth with such majestic scenery. Top 5 Things to do in Halong Bay.',
                    style: TextStyle(
                      fontSize: 20,
                      ),
                  ),
          ], ),
         ),
      const Padding(
         padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
         child: Text(
           'Hình ảnh',
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 18
           ),
         ),
         ),
        // Phía dưới là phần List Images của 1 địa danh
       Padding(
         padding:const EdgeInsets.all(8.0),
         child: CarouselSlider(
           options: CarouselOptions(
             autoPlay: true,
           ),
           items: imageList.map((e) => ClipRRect(
             borderRadius: BorderRadius.circular(8.0),
             child: Stack(
               fit: StackFit.expand,
               children:<Widget> [
                 Image.network(e,
                 width: 800,
                 height: 160,
                 fit: BoxFit.cover,)
               ],
             ),
           )).toList(),
         ),
         )
        ],
      ),
    )
    );
  }

}