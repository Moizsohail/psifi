import '../pages/notificationportal.dart';
import '../pages/loginregisterpage.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
class Mappings extends StatefulWidget{
  final AuthImplementation _auth;
  Mappings(this._auth);
  @override
  State<StatefulWidget> createState() => MappingsState();

}
enum LoginState{
  loggedIn,
  notLoggedIn
}
class MappingsState extends State<Mappings>{
  //final FirebaseMessaging _messaging = FirebaseMessaging();
  
  //LoginState _loginState = LoginState.notLoggedIn;
  LoginState _loginState = LoginState.notLoggedIn;
  @override
  void initState(){
    super.initState();
    
    //FireBase Messaging
    // _messaging.getToken().then((token){
    //   print(token);
    // });

    
    // FireBase Auth
    widget._auth.getCurrentUser().then((id)=>
      setState(()=>
        _loginState = (id == null? LoginState.loggedIn:LoginState.notLoggedIn)
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      body: new StreamBuilder(
        stream: widget._auth.onAuthStateChanged(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            return NotificationPortal(widget._auth,()=>
              setState((){
                _loginState = LoginState.notLoggedIn;
              }));
          }
          return LoginRegisterPage(widget._auth,()=>
            setState((){
              _loginState = LoginState.loggedIn;
            }));
        },
      )
    );
    // switch(_loginState){
    //   case LoginState.loggedIn:
    //     return NotificationPortal(true,widget._auth,()=>
    //       setState((){
    //         _loginState = LoginState.notLoggedIn;
    //       }));
        
    //     break;
    //   case LoginState.notLoggedIn:
    //     return LoginRegisterPage(widget._auth,(){
    //       setState((){
    //         _loginState = LoginState.loggedIn;
    //       });
    //     });
    //     break;
    // }
  }

}