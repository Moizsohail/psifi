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
        primaryColor: Colors.black, 
        accentColor: Colors.amberAccent,
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.amberAccent,
          )
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.white
        ),
        appBarTheme: AppBarTheme(
          color: Colors.black
        ),
        bottomAppBarColor: Colors.red
      ),
      //home: Temp(), google maps test
      home: Mappings(Auth()),
    );
  }
}

