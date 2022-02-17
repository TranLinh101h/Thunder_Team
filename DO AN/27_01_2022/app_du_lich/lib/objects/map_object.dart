import 'package:latlong2/latlong.dart';

class RoadMap {
  double? distance;
  double? times;
  List<dynamic>? lat;

  RoadMap({this.distance, this.times, this.lat});

  factory RoadMap.fromJson(Map<String, dynamic> r) {
    return RoadMap(
        distance: r["properties"]["segments"][0]["distance"],
        times: r["properties"]["segments"][0]["duration"],
        lat: r["geometry"]["coordinates"]);
  }
}
