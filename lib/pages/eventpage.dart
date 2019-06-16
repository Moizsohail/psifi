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
            height: 200,
        ),
        // Center(
        //   child: CircleAvatar(
        //     backgroundImage: NetworkImage(widget._doc['LogoURL']),
        //     backgroundColor: Theme.of(context).accentColor,
        //     maxRadius: 30,
        //   ),
        // ),
        SizedBox(height: 8.0),
        Text(' Description:',style: new TextStyle(fontSize: 14.0, color: Colors.grey)),
        Text(' \"' + widget._doc['LongDesc'] + '\"', style: new TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)),
        SizedBox(height: 14.0),
        Text(' Event Heads:',style: new TextStyle(fontSize: 14.0, color: Colors.grey)),
        Text(' TBA',style: new TextStyle(fontSize: 18.0)),   
      ],
    )
    
    );
  } //display priority here.
}