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
        Stack(children: <Widget>[
            Container(
            child: Image(
              image: NetworkImage(widget._doc['LogoURL']),
              fit: BoxFit.cover,
              height: 170,
              width: 400,
            ),
            decoration: new BoxDecoration(
              border: Border(bottom: BorderSide(width: 1.2, color: Theme.of(context).accentColor)),
              shape: BoxShape.rectangle,
              color: Colors.transparent,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 10.0,
                ),
              ],
            ),
          ),

          Padding(
          padding: EdgeInsets.only(top: 120.0,left: 10.0),
          child: 
          Container(
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget._doc['LogoURL']),
              backgroundColor: Theme.of(context).accentColor,
              maxRadius: 40,
            ),
            decoration: new BoxDecoration(
              border: new Border.all(width: 1.2, color: Theme.of(context).accentColor),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10.0,
                ),
              ],
            ),
          ),
        ),

      
        ],),
        Padding(
          padding: EdgeInsets.only(top:10.0, bottom: 15.0, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Text(' Description:',style: new TextStyle(fontSize: 14.0, color: Colors.grey)),
            SizedBox(height: 8.0),
            Text(' \"' + widget._doc['LongDesc'] + '\"', style: new TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic)),
            SizedBox(height: 16.0),
            Text(' Event Heads:',style: new TextStyle(fontSize: 14.0, color: Colors.grey)),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget._doc['LogoURL']),
                    backgroundColor: Theme.of(context).accentColor,
                    maxRadius: 30,
                  ),
                  Text(widget._doc['EH1'], style: new TextStyle(fontSize: 16.0)),
                  Row(children: <Widget>[Icon(Icons.phone, size: 15.0, color: Theme.of(context).primaryColor), Text(' ' + '0900 7860100', style: new TextStyle(fontSize: 14.0)),],),
                ],),
                Column(children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget._doc['LogoURL']),
                    backgroundColor: Theme.of(context).accentColor,
                    maxRadius: 30,
                  ),
                  Text(widget._doc['EH2'], style: new TextStyle(fontSize: 16.0)),
                  Row(children: <Widget>[Icon(Icons.phone, size: 15.0, color: Theme.of(context).primaryColor), Text(' ' + '0900 7860100', style: new TextStyle(fontSize: 14.0)),],),
                ],),
            ],),
          ],),
        ),
      ],
      ),
    );
  } //display priority here.
}