import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget{
  final DocumentSnapshot _doc; //data read from firestore for the event page
  EventPage(this._doc);
  @override
  State<StatefulWidget> createState() => EventPageState(); //notification page state created
}

class EventPageState extends State<EventPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text(widget._doc['Title']),), //appbar text assigned Title field in data from doc
    body:  
    ListView(
      children: <Widget>[
        Image(
            image: NetworkImage(widget._doc['LogoURL']),
            fit: BoxFit.cover,
        ),
        Text(widget._doc['ShortDesc']),
        Text(widget._doc['LongDesc']),
      ],
    )
    
    );
  } //display priority here.
}