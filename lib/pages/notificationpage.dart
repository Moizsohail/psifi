import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:psifi/utils/parseMessage.dart';

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
          body: Text(widget._doc['Description']),
          headerSliverBuilder: (context,innerBoxIsScrolled) => <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget._doc['Title']),
                  background:Hero(
                    child:Image.asset('${tempDir.path}/${widget._doc["PublisherId"]}.png',
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

}