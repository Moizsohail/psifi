import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:psifi/pages/temp2.dart';

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
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (content,index){
          return card(index.toString());
        },
        
        
        )
    );
  }
  Widget getMap(){
    return GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom : 11.0
        ),
      );
  }
  Widget card(String index){
    return Material(
      child:ListTile(
        
        dense: false,
        leading: Hero(
              child:CircleAvatar(
              radius: 25.0,
              backgroundImage: ExactAssetImage('images/b.jpg'),
              //child: Image.asset('images/b.jpg'),
            ),
            tag: "a"+index
          ),
              
        title: Text("Hiaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",overflow: TextOverflow.ellipsis,),
        subtitle: Text("message"),
        trailing: Text("18 days ago"),
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=> Temp2(index.toString())));
        },
        onLongPress: (){
          print("long press");
        },
      ),
      elevation: 2,
    );
  }
}
