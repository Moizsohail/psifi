import 'package:flutter/material.dart';
import 'package:psifi/pages/notificationportal.dart';
import 'package:psifi/pages/registrationLanding.dart';
import 'package:psifi/utils/authentication.dart';
import 'package:psifi/pages/eventsportal.dart';

class Navigation extends StatefulWidget{
  final AuthImplementation _auth;
  Navigation(this._auth);
  @override
  State<StatefulWidget> createState() => NavigationState();
}

class NavigationState extends State<Navigation> with SingleTickerProviderStateMixin{  
  TabController _tabController;
  String _title = "Notifications";
  bool _isAdmin = false;
  List<String> adminList = ["9pm3dNrzfxat1no1QhSN69zjBoF3", "XFGTcWUaOdhegTNYJ06BlTk7JhN2"]; //update

  @override
  void initState(){
    super.initState();
    widget._auth.getCurrentUserUID().then((userUID){
      _isAdmin = adminList.contains(userUID); //if adminlist contains the user UID then isAdmin
    });

    _tabController = TabController(length: 4,vsync: this);
    _tabController.addListener((){
      setState(() {
        switch (_tabController.index){
          case 0:
            _title = "Notifications";
            break;
          case 1:
            _title = "Events";
            break;
          case 2:
            _title = "Register";
            break;
          case 3:
            _title = "Socials";
            break;
        }
      });
    });
  }
  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              widget._auth.signOut();
            },
          )
        ],
        title: Text(_title),
        
      ),
      
      body: TabBarView(
        children: <Widget>[
          NotificationPortal(widget._auth, _isAdmin),
          EventsPortal(_isAdmin),
          RegistrationLanding(),
          Text("5")
        ],
        controller: _tabController,
      ),
      
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Icon(Icons.announcement),
            ),
            Tab(
              child: Icon(Icons.event),
            ),
            Tab(
              child: Icon(Icons.payment),
            ),
            Tab(
              child: Icon(Icons.people),
            )
            ],
          ),
        ),
      );
  }
}