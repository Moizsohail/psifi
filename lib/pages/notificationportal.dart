import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psifi/utils/authentication.dart';

import 'notificationadmin.dart';
import 'notificationpage.dart';
class NotificationPortal extends StatefulWidget{
  final AuthImplementation _auth;
  final VoidCallback _onSignOut;
  NotificationPortal(this._auth,this._onSignOut){
    
  }
  
  @override
  State<StatefulWidget> createState() => NotificationPortalState();
}
class NotificationPortalState extends State<NotificationPortal>{
  bool _isAdmin = false;
  
  @override
  void initState(){
    super.initState();
    widget._auth.getCurrentUser().then((e){
      _isAdmin = "yX7PXQgC75b7XUgqLB2FbDczVR92" == e;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: _isAdmin? FloatingActionButton(
        child: Icon(Icons.add)
        , onPressed: () {
           Navigator.push(context,
           MaterialPageRoute(builder: (context)=> NotificationAdmin(null,false)
           ));
        },
      ):null,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.time_to_leave),
            onPressed: (){
              widget._auth.signOut();
              widget._onSignOut();
            },
          )
        ],
        title: Text("Notifications"),
      ),
      body: getNotifs(),
    );
  }
  String dateParser(DateTime fsdate){
    DateTime now = DateTime.now();
    //DateTime.parse("1969-07-20 20:18:04Z")
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
  Widget card(DocumentSnapshot doc){
    
    return Container(
      decoration:  BoxDecoration(
        border: Border(
          left: BorderSide(
            color: (priority){
              if (priority == 0){
                return Colors.greenAccent;
              }
              if (priority == 1){
                return Colors.blueAccent;
              }
              if (priority == 2){
                return Colors.redAccent;
              }
            }(doc['Priority']),
            width: 3.0,
          ),
          bottom: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        )
      ),
      child: InkWell(
        onTap:(){

          Navigator.push(context,
           MaterialPageRoute(builder: (context)=> NotificationPage(doc)
           ));
        },
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          SizedBox(height:5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(doc['Title'],
              style: TextStyle(fontSize: 30),
              overflow: TextOverflow.ellipsis
              ),
              Row(children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit), 
                  onPressed: () =>
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> NotificationAdmin(doc,true)
                      ))
                  ,),
                Text(dateParser(doc['PostTime'])),  
              ],)
              
            ]
          ),
          SizedBox(height:5),
          Text(' ' + doc['Description'],
            maxLines:2,
            overflow: TextOverflow.ellipsis
          ),
          SizedBox(height:10)
          ],
        )
      )
    );
  }
  Widget getNotifs(){
    //print(Firestore.instance.collection('tasks'));
    return Container(
      padding: EdgeInsets.all(10.0),
      child: StreamBuilder(
        stream: Firestore.instance.collection('Notifications').snapshots(),
        builder: (context, snapshot){
          //print("YO"+snapshot.data.documents[0]['Title'].toString());
          if (snapshot.hasError){
            return new Text("ERROR ${snapshot.error}");
          }
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder:(context,index) =>
                card(snapshot.data.documents[index])
            );
          }
          return Container();
        },
      )
    );
  }
}
