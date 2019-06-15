import '../pages/loginregisterpage.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:psifi/utils/navigation.dart';

//import 'package:firebase_messaging/firebase_messaging.dart';

class Mappings extends StatefulWidget{ //stateful
  final AuthImplementation _auth; //authImp object
  Mappings(this._auth); //constructor
  @override
  State<StatefulWidget> createState() => MappingsState();
}

enum LoginState{ loggedIn, notLoggedIn } //enum to toggle between login states

class MappingsState extends State<Mappings>{
  //final FirebaseMessaging _messaging = FirebaseMessaging();
  LoginState _loginState = LoginState.notLoggedIn; //by default not logged in
  
  @override
  void initState(){
    super.initState();
    //FireBase Messaging
    //_messaging.getToken().then((token){ print(token);});
  
    // FireBase Auth
    widget._auth.getCurrentUserUID().then((id)=> //User UID checked
      setState(()=> _loginState = (id == null ? LoginState.loggedIn : LoginState.notLoggedIn))
    ); //if id is null then set state to loggedIn else notLoggedin
    print(_loginState);
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold( //MappingsState is a visual scaffold with StreamBuilder body
      body: new StreamBuilder(
        //tracking a FirebaseUser stream for the auth Implementation object to see if the auth state changes (login) and build accordingly
        stream: widget._auth.onAuthStateChanged(), //latest snapshot of interaction = stream
        builder: (context,snapshot){ //build strategy given by = builder, cannot be null, context and async snapshot given
          if (snapshot.hasData){
            return Navigation(widget._auth); //returns a Navigation with the auth
          }
          return LoginRegisterPage(widget._auth,()=> setState((){_loginState = LoginState.loggedIn;})); 
        }
      )
    );
  }
}