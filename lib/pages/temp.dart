import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Temp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TempState();
  }
}
class TempState extends State<Temp>{
  Completer<GoogleMapController> _controller =  Completer();
  static const LatLng _center = const LatLng(24.956384,67.109108);
  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom : 11.0
        ),
      ),
    );
  }

}