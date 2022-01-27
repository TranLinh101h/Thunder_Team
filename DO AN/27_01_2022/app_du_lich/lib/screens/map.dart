/*import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);
  void _OnMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.hybridDay, (p0) {
      if (p0 != null) {
        print('Có lỗi xảy ra!!!' + p0.toString());
      } else {
        hereMapController.camera
            .lookAtPointWithDistance(GeoCoordinates(35.15091, 138.69518), 500);
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.map), Text('MAP')],
          ),
        ),
      ),
      body: HereMap(
        onMapCreated: _OnMapCreated,
      ),
    );
  }
}
*/