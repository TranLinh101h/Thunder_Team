import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/dia_danh_object.dart';
import 'package:app_du_lich/provider/dia_danh_provider.dart';
import 'package:flutter/material.dart';

import 'chi_tiet_dia_danh.dart';

class DiaDanhMien extends StatefulWidget {
  final String mien;
  DiaDanhMien({Key? key, required this.mien}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DiaDanhMienState(mien: mien);
  }
}

class DiaDanhMienState extends State<DiaDanhMien> {
  final String mien;
  List<dynamic> lstDiaDanh = [];
  DiaDanhMienState({required this.mien});

  void load() async {
    String id = mien.toLowerCase().contains('b')
        ? '1'
        : mien.toLowerCase().contains('t')
            ? '2'
            : '3';
    ApiResponse response = await getDiaDanhTheoMien(id);
    if (response.error == null) {
      if (response.data != null) {
        if (mounted)
          setState(() {
            lstDiaDanh = response.data! as List<dynamic>;
          });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  List<String> lstImage = [
    'images/img1.jpg',
    'images/img2.jpg',
    'images/img3.jpg',
    'images/img4.jpg',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              //  Bai_Viet baiviet = baiviet;
              return <Widget>[
                SliverAppBar(
                  backgroundColor: mien.toLowerCase().contains('b')
                      ? Colors.red
                      : mien.toLowerCase().contains('t')
                          ? Colors.green
                          : Colors.blue,
                  expandedHeight: 300.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      mien,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    background: Stack(
                      children: [
                        Center(
                          child: Image.asset('images/img3.jpg'),
                        ),
                      ],
                    ),
                  ),
                )
              ];
            },
            body: Container(
              margin: EdgeInsets.all(5),
              child: ListView.builder(
                  itemCount: lstDiaDanh.length,
                  itemBuilder: (context, index) {
                    Dia_Danh diaDanh = lstDiaDanh[index];
                    return Card(
                      child: ListTile(
                        title: Text(diaDanh.ten_dia_danh.toString()),
                        subtitle: Text(
                          diaDanh.ngay_Tao.toString(),
                          maxLines: 1,
                        ),
                        leading: SizedBox(
                          width: 100,
                          height: 150,
                          child: Image.asset(lstImage[index]),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrangChiTietDiaDanh(
                                        diaDanh: diaDanh,
                                      )));
                        },
                      ),
                    );
                  }),
            )));
  }
}
