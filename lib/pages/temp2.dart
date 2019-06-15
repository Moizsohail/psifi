import 'package:flutter/material.dart';

class Temp2 extends StatefulWidget{
  final String _id;
  Temp2(this._id);
  @override
  State<StatefulWidget> createState() {    
    return Temp2State();
  }
}
class Temp2State extends State<Temp2>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child:Hero(
        child:CircleAvatar(                  
            radius: 50.0,
            backgroundImage: ExactAssetImage('images/b.jpg'),
          ),
        tag: "a"+widget._id,
      ))
    );
  }

}