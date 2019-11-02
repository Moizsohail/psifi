import 'package:flutter/cupertino.dart';
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
      theme: ThemeData(
        primaryColor: Color(0xff060e66), 
        accentColor: Colors.white,
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.white
          )
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.redAccent[100]
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xff060e66)
        ),
        bottomAppBarColor: Colors.red
      ),
      //home: Temp(), google maps test
      home: Mappings(Auth()),
    );
  }
}

