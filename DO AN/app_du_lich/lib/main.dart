import 'package:app_du_lich/screens/dang_nhap_dang_ky/loading.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "App Du Lịch",
    theme: ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: "Josefin",
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: 'welcome',
    routes: {
      'welcome': (context) => Loading(),
    },
  ));
}
