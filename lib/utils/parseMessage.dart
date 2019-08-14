import 'dart:convert';

import 'package:flutter/widgets.dart';

class ParseMessage extends StatefulWidget{
  final String _message;
  ParseMessage(this._message);
  @override
  State<StatefulWidget> createState() => ParseMessageState();

}

class ParseMessageState extends State<ParseMessage>{
  
  List<Widget> breakUp(){
    var decoder = JsonDecoder();
    var dic = decoder.convert(widget._message);
    print(dic);
    return null;
  } 
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context,index){
        return Text("hi");
      },
    );
  }

}