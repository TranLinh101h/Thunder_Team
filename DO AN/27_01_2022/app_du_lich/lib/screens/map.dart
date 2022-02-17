import 'dart:async';

import 'package:app_du_lich/objects/api_response.dart';
import 'package:app_du_lich/objects/map_object.dart';
import 'package:app_du_lich/provider/processed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../constant.dart';

class MyMap extends StatefulWidget {
  LatLng diaDanh;
  LatLng myLocation;
  RoadMap roadMap;
  MyMap(
      {Key? key,
      required this.diaDanh,
      required this.myLocation,
      required this.roadMap})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyMapState(
        diaDanh: diaDanh, myLocation: myLocation, roadMap: roadMap);
  }
}

class MyMapState extends State<MyMap> {
  MyMapState(
      {Key? key,
      required this.diaDanh,
      required this.myLocation,
      required this.roadMap});
  LatLng diaDanh;
  LatLng myLocation;
  RoadMap roadMap;
  List<LatLng> _polylinePoints = []; //Lay danh sách tọa độ vẽ đường đi

  void getRoadMap() {
    for (dynamic item in roadMap.lat as List<dynamic>) {
      LatLng point = new LatLng(item[1], item[0]);
      _polylinePoints.add(point);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoadMap();
  }

  @override
  Widget build(BuildContext context) {
    double quangDuong = roadMap.distance! / 1000;
    double thoiGian = roadMap.times! / 60;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quãng đường: ${quangDuong.round()} km",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "  Thời gian: ${thoiGian.round()} phút",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: _polylinePoints.length == 0
                    ? Image.asset('images/loading2.gif')
                    : FlutterMap(
                        options: MapOptions(
                            center: LatLng(
                                myLocation.latitude, myLocation.longitude),
                            zoom: 10),
                        layers: [
                          TileLayerOptions(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                          ),
                          new MarkerLayerOptions(markers: [
                            Marker(
                                point: LatLng(
                                    myLocation.latitude, myLocation.longitude),
                                builder: (context) => Icon(
                                      Icons.pin_drop,
                                      color: Colors.red,
                                    )),
                            Marker(
                                point:
                                    LatLng(diaDanh.latitude, diaDanh.longitude),
                                builder: (context) => Icon(
                                      Icons.pin_drop,
                                      color: Colors.blue,
                                    ))
                          ]),
                          new PolylineLayerOptions(polylines: [
                            new Polyline(
                                points: _polylinePoints,
                                strokeWidth: 5,
                                color: Colors.blue)
                          ])
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
