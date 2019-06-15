import 'package:flutter/material.dart';
import 'utils/mappings.dart';
import 'utils/authentication.dart';
//import 'pages/temp.dart'; 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget { //ROOT
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PSIFI XI',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(primaryColor: Colors.amber),
      //home: Temp(), google maps test
      home: Mappings(Auth()),
    );
  }
}

