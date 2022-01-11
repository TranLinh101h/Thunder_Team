import 'package:app_du_lich/screens/chi_tiet_dia_danh.dart';
import 'package:app_du_lich/screens/trang_ca_nhan.dart';
import 'package:flutter/material.dart';

class TimKiem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimKiemState();
  }
}

class TimKiemState extends State<TimKiem> {
  TextEditingController name = TextEditingController();
  List<String> lstImage = [
    'images/img1.jpg',
    'images/img2.jpg',
    'images/img3.jpg',
    'images/img4.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: TextField(
                  onSubmitted: (String value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TrangCaNhan()));
                  },
                  controller: name,
                  onChanged: (String value) {},
                  decoration: InputDecoration(
                      prefix: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: " Nhập địa danh",
                      hintStyle: TextStyle(color: Colors.white),
                      suffixStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          )),
      body: Container(
        margin: EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              title: Text('Title'),
              subtitle: Text(
                'Content',
                maxLines: 1,
              ),
              leading: SizedBox(
                width: 100,
                height: 120,
                child: Image.asset(lstImage[index]),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrangChiTietDiaDanh()));
              },
            ),
          ),
        ),
      ),
    );
  }
}
