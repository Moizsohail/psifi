import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psifi/utils/authentication.dart';
import 'package:psifi/utils/firestorehelper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../utils/cachedImageProvider.dart';
import 'notificationadmin.dart';
import 'notificationpage.dart';

class NotificationPortal extends StatefulWidget{
  final AuthImplementation _auth;
  final bool _isAdmin;
  NotificationPortal(this._auth, this._isAdmin); //empty constructor body
  
  @override
  State<StatefulWidget> createState() => NotificationPortalState();
}

class NotificationPortalState extends State<NotificationPortal>{
  bool firstTime = true;
  CachedImageProvider _imageProvider = CachedImageProvider();
  FirestoreHelper _firestore = FirestoreHelper("Notifications");

  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget._isAdmin ? FloatingActionButton(
        child: Icon(Icons.add, color: Theme.of(context).accentColor,), 
        backgroundColor: Theme.of(context).primaryColor,
        onPressed:(){
           Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationAdmin(widget._auth, null, false)));
        },
      ):null,
      body: getNotifs(),
    );
  }
  
  String dateParser(DateTime fsdate){
    DateTime now = DateTime.now();
    Duration diff = now.difference(fsdate);
    if (diff.inDays > 365){
      if ((diff.inDays ~/ 365) == 1){
        return "Last Year";
      }
      return "${(diff.inDays ~/ 365)} Years Ago";
      
    }
    if (diff.inDays > 30){
      if ((diff.inDays ~/ 30) == 1){
        return "Last Month";
      }
      return "${(diff.inDays ~/ 30)} Months Ago";
    }
    if (diff.inDays >= 1){
      if (diff.inDays == 1){
        return "Yesterday";
      }
      return "${diff.inDays} Days Ago";
    }
    if (diff.inHours >= 1){
      if (diff.inHours == 1){
        return "Last Hour";
      }
      return "${diff.inHours} Hours Ago";
    }
    if (diff.inMinutes >= 1){
      if (diff.inMinutes == 1){
        return "A Minute Ago";
      }
      return "${diff.inMinutes} Minutes Ago";
    }
    return "Just Now";
  }
  
  

  Widget notifCard(DocumentSnapshot doc){
    String fileName = doc['PublisherId'] + '.jpg'; //get image fileName from publisher's ID
    this._imageProvider.addName(fileName).then((isDownloaded){
        if(isDownloaded){
          setState(() {});
        }
    });
    print("before");
    return ListTile(
      onTap: () { //tapping a notification opens up its (doc's) notification page
        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(doc)));
      },      
      leading: Hero(
          child: CircleAvatar(
            backgroundImage: this._imageProvider.getImage(fileName),
            backgroundColor: Theme.of(context).accentColor,
          ),
          tag: "lol"+doc.documentID,
        ),
      title: Text(doc['Title'],
          style: TextStyle(fontSize: 30), overflow: TextOverflow.ellipsis,),
      trailing: Text(dateParser(DateTime.fromMicrosecondsSinceEpoch(
          doc['PostTime'].seconds * 1000000))),
      subtitle: Text(' ' + doc['Description'],
          maxLines: 2, overflow: TextOverflow.ellipsis),
    );
  }     
  
Widget getNotifs() {
    //print(Firestore.instance.collection('tasks'));
    var tapPosition;
    /*
      Wait for the downloads finish.
     */
    return Container(
      //padding: EdgeInsets.symmetric(horizontal:10.0),
      child: StreamBuilder(
        stream: Firestore.instance.collection('Notifications').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return new Text("ERROR ${snapshot.error}");
          }
          if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                reverse: true,
                itemBuilder: (context, index) => GestureDetector(
                    onTapDown: (details) => tapPosition = details.globalPosition,
                    onLongPress: () => _onLongPressMenu(tapPosition, snapshot.data.documents[index]),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 2.0),
                      child: Material(
                        elevation: 2,
                        child: notifCard(snapshot.data.documents[index])),
                      )
                    )
              );
          }
          return Center(child:CircularProgressIndicator());
          //}
        }
      ));
  }

  void _onLongPressMenu(var tapPosition, DocumentSnapshot doc) async{
    if (await widget._auth.getCurrentUserUID() != doc['PublisherId']) return;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    showMenu(
      context: context,
      items: [
        PopupMenuItem(value: 1, child: Row(children: <Widget>[Icon(Icons.edit), Text("Edit")],),),
        PopupMenuItem(value: 2, child: Row(children: <Widget>[Icon(Icons.delete), Text("Delete"),],),)
      ],
      position: RelativeRect.fromRect(
          tapPosition & Size(40, 40), Offset.zero & overlay.size))
      .then((e) {
      switch (e) {
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationAdmin(widget._auth,doc, true)));
          break;
        case 2:
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  Center(child:Text("Are you sure you want to delete \"${doc['Description']}\"?", textAlign: TextAlign.center,),),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blueAccent,
                        onPressed: () {
                          _firestore.deleteData(doc);
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      RaisedButton(
                        child: Text(
                          "No!",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.redAccent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              );
            });
          //_firestore.deleteData(doc);
          break;
      }
    });
  }
}
