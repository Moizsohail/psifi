import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Pop extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => PopState();

}
class PopState extends State<Pop>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:_simplePopUp()
    );
  }
}
Widget _simplePopUp() => PopupMenuButton<int>(
  child: RaisedButton(
    onPressed: (){},
    child: Text("hiaar"),
  ),
  itemBuilder: (context)=>[
    PopupMenuItem(child: Text("hi"),value: 1,)
  ],
);