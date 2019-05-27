import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget{
  final DocumentSnapshot _doc;
  NotificationPage(this._doc);
  @override
  State<StatefulWidget> createState() => NotificationPageState();

}
class NotificationPageState extends State<NotificationPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text(widget._doc['Title']),),
    body: Text(widget._doc['Description']),);
  }

}