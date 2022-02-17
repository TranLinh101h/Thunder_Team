import 'dart:async';

import 'package:app_du_lich/screens/dang_nhap_dang_ky/loading.dart';
import 'package:flutter/material.dart';

class ManHinhCho extends StatefulWidget {
  const ManHinhCho({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ManHinhChoState();
  }
}

class ManHinhChoState extends State<ManHinhCho> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), (){
      Navigator.push(context, 
        MaterialPageRoute(builder: (context) => const Loading() )
       );
    });
  }
//width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children :[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/welcomeScreen.png'),
                fit: BoxFit.cover
              )
            ),
          ),
        const Align(
           alignment: Alignment.center,
           child:  CircularProgressIndicator(
             valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
          )),
        ]
      ),
    );
  }
}