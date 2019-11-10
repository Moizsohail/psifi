import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

//normal notification page
class NotificationPage extends StatefulWidget{
  final DocumentSnapshot _doc; //data read from firestore for the notification page
  NotificationPage(this._doc);
  @override
  State<StatefulWidget> createState() => NotificationPageState(); //notification page state created
}

class NotificationPageState extends State<NotificationPage>{
  final Directory tempDir = Directory.systemTemp;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(widget._doc['Description']),
                conditionalURL()
              ]     
            ) 
            ),
          headerSliverBuilder: (context,innerBoxIsScrolled) => <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget._doc['Title'], style: TextStyle(backgroundColor: Color(0xFF800000))),
                  background:Hero(
                    child:Image.asset('images/psifixilogo.png', // ${tempDir.path}/${widget._doc["PublisherId"]}.png
                        fit: BoxFit.cover,
                    ),
                    tag: widget._doc.documentID,
                  )
                ),
              )
            ],
        ),
      //child:Image.asset('${tempDir.path}/${widget._doc["PublisherId"]}.jpg'),
    );
    // body: ParseMessage(json.convert(col)));
  } //display priority here.

  Widget conditionalURL(){
    if (widget._doc['URL'] == ""){
      return Container(); //empty
    }
    // return new InkWell(
    //   child: new Text(widget._doc['URL'], style: new TextStyle(fontSize: 16.0, color: Colors.blue[400], decoration: TextDecoration.underline)),
    //   onTap: () => launch(widget._doc['URL'])
    // );
    return new RaisedButton(
      onPressed: () {launch(widget._doc['URL']);},
      textColor: Colors.white,
      color: Color(0xFF800000),
      padding: EdgeInsets.only(),
      elevation: 6,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget._doc['URL'].substring(0,36),style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            SizedBox(width: 10.0),
            Icon(FontAwesomeIcons.externalLinkSquareAlt),
          ],
        )
    ); //otherwise container returned
  }
}