import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psifi/utils/firestorehelper.dart';

import 'eventsadmin.dart';
import 'eventpage.dart';

class EventsPortal extends StatefulWidget{
  final bool eventsIsAdmin;
  EventsPortal(this.eventsIsAdmin); //empty constructor body
  
  @override
  State<StatefulWidget> createState() => EventsPortalState();
}

class EventsPortalState extends State<EventsPortal>{
  bool _isAdmin = false;
  FirestoreHelper _firestore = FirestoreHelper("Events");
  
  @override
  void initState(){
    super.initState();
    _isAdmin = widget.eventsIsAdmin;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isAdmin? FloatingActionButton(
        child: Icon(Icons.add, color: Theme.of(context).primaryColor,), 
        backgroundColor: Theme.of(context).accentColor,
        onPressed:(){
          //Adding events.
          Navigator.push(context, MaterialPageRoute(builder: (context)=> EventsAdmin(null,false)));
        },
      ):null,
      body: getEvents(),
    );
  }
  
  Widget eventCardBox(DocumentSnapshot doc){
    var tapPosition;
    return Container(
      //padding: new EdgeInsets.only(left:12.0, right: 10.0, bottom: 3.0, top: 3.0),      
      child: InkWell(
        onTapDown: (details){
          tapPosition = details.globalPosition;
        },
        onLongPress: (){
          if (!_isAdmin) return;
          final RenderBox overlay = Overlay.of(context).context.findRenderObject();
          showMenu(
            context: context,
            items: [
              PopupMenuItem(value: 1, child: Row(children: <Widget>[Icon(Icons.edit), Text("Edit Event")],),),
              PopupMenuItem(value: 2, child: Row(children: <Widget>[Icon(Icons.delete), Text("Delete Event"),],),)
            ], 
            position: RelativeRect.fromRect(tapPosition & Size(40,40), Offset.zero & overlay.size)
          ).then((e){
            switch (e){
              case 1:
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EventsAdmin(doc,true)));
                break;
              case 2:
                showDialog(
                  context: context,
                  builder: (context){
                    return SimpleDialog(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Center(child:Text("Are you sure you want to delete the event \"${doc['Title']}\"?", textAlign: TextAlign.center,),),
                        SizedBox(height: 10.0,),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,  
                        children: <Widget>[
                          RaisedButton(child: Text("Yes",style: TextStyle(color: Colors.white),),color: Colors.blueAccent, onPressed: () {
                            _firestore.deleteData(doc);          
                            Navigator.pop(context);
                          },),
                          SizedBox(width: 40.0,),
                          RaisedButton(child: Text("No!",style: TextStyle(color: Colors.white),),color: Colors.redAccent,onPressed: () {
                            Navigator.pop(context);
                          },)  
                          ],
                        )
                      ],
                    );                 
                  }
                );
                break;
              }  
            }
          );
        },

        onTap:(){ //tapping a notification opens up its (doc's) notification page
          Navigator.push(context, MaterialPageRoute(builder: (context)=> EventPage(doc)));
        },

        child: EventCard(
          title: new Text(' ' + doc['Title'],style: new TextStyle(fontSize: 30.0)),
          shortDesc: new Text('   ' + doc['ShortDesc'], style:new TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic)),
          logo: NetworkImage(doc['LogoURL']),
          //OR logo: AssetImage("images/techwars.png")
        ),
      )
    );
  }
  
  
  Widget getEvents(){
    //print(Firestore.instance.collection('tasks'));
    return Container(
      //padding: EdgeInsets.symmetric(horizontal:10.0),
      child: StreamBuilder(
        stream: Firestore.instance.collection('Events').snapshots(),
        builder: (context, snapshot){
          if (snapshot.hasError){
            return new Text("ERROR ${snapshot.error}");
          }
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder:(context,index) =>
                GestureDetector(
                  onLongPress: (){
                  },
                  child: eventCardBox(snapshot.data.documents[index])
                ),
            );
          }
          return Container();
        },
      )
    );
  }
}

class EventCard extends StatelessWidget {
  final Widget title;
  final Widget shortDesc;
  final ImageProvider logo;

  EventCard({this.title, this.shortDesc, this.logo});
  
  @override
  Widget build(BuildContext context){
    return new Card(
          elevation: 2.5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                Image(
                    image: this.logo,
                    fit: BoxFit.cover,
                ),
                this.title,
                this.shortDesc,
                SizedBox(height: 15.0),
              ],
          ),
    );
  }
}
