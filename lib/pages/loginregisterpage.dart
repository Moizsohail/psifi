import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:psifi/utils/firestorehelper.dart';


import '../utils/authentication.dart';
import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget{
  final AuthImplementation _auth;
  final VoidCallback _onLoggedIn;
  LoginRegisterPage(this._auth,this._onLoggedIn);
  @override
  State<StatefulWidget> createState() => LoginRegisterPageState();
}
enum FormType{
  login,
  register
}
enum LoginButtonState{
  normal,
  loading,
  success
}
class LoginRegisterPageState extends State<LoginRegisterPage>{
  LoginButtonState _loginButtonState = LoginButtonState.normal;
  final formKey = GlobalKey<FormState>();
  final FirebaseMessaging _messaging = FirebaseMessaging();
  FirestoreHelper _firestore = FirestoreHelper("pushtokens");
  
  void fireMessagingListeners(){
    _messaging.configure(
      onMessage: (message) async =>
        print('onMessage $message'),
      onResume: (message) async =>
        print('onResume $message'),
      onLaunch: (message) async =>
        print('onlaunch $message')
    );
  }
  
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";
  //final FirestoreHelper _firestore = FirestoreHelper("pushCodes");
  @override void initState() {
    super.initState();
      _messaging.getToken().then((token){
        print(token);
        _firestore.addUniqueData({"devtoken":token},"devtoken");
      });
      fireMessagingListeners();
  }
  Widget button(){
    switch (_loginButtonState){
      case LoginButtonState.normal:
        return Center(child:Text(_formType==FormType.login ? "Login": "Register",style: TextStyle(color: Colors.white),));
      default:
        return Container(
          height: 40,
          padding: EdgeInsets.symmetric(vertical:2.0),
          child:FlareActor("animations/loadingandok.flr",
            fit: BoxFit.contain,
            color: Colors.white,
            animation: _loginButtonState == LoginButtonState.loading ? "loading":"ok",
        ),
      );
    }
  }
  void validateAndSubmit(){
    setState(()=>_loginButtonState = LoginButtonState.loading);
    
    if (validateAndSave()){
      switch(_formType){
        case FormType.login:
          widget._auth.SignIn(_email,_password).then((e){
            setState(()=>_loginButtonState = LoginButtonState.success);
            widget._onLoggedIn();
           // _firestore.addUnqiueData({}, "key");
          }).catchError((e){
            print("ERROR YO BITCH ${e.toString()}");
            setState(()=>_loginButtonState = LoginButtonState.normal);
          });
          
          break;
        case FormType.register:
          widget._auth.Register(_email,_password).then((e)=>
            widget._onLoggedIn()
          ).catchError((e)=>print("MR. REG HAS PROBLEMS BRO: ${e.toString()}"));
          break;
      }
    }
  }
  bool validateAndSave(){
    final form =  formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    }
    return false;
  }
  void moveToLogin(){
    formKey.currentState.reset();
    setState((){
      _formType = FormType.login;
    });
  } 
  void moveToRegister(){
    formKey.currentState.reset();
    setState((){
      _formType = FormType.register;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("PSIFI XI"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key:formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10,),
              // Hero(
              //   child:CircleAvatar(
              //     backgroundColor: Colors.black,
              //     radius: 110.0,
              //     child: Image.asset('images/a.jpg'),
              //   ),
              //   tag:"lol"
              // ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (value){
                  print(value);
                  return value.isEmpty ? "Email should not be empty":null;
                },
                onSaved: (value){
                  print(value);
                  return _email = value;
                }
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                validator: (value){
                  return value.isEmpty ? "Password should not be empty":null;
                },
                
                onSaved: (value){
                  return _password = value;
                }
              ),
              SizedBox(height: 10,),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(5),
                child: Container(
                  height:30.0,
                  child: button(),),
                
                onPressed: validateAndSubmit,
              ),

              FlatButton(
                child: Text(_formType==FormType.login ? "Don't Have An Account? Register": 
                "Already Have An Account? Login"),
                onPressed: (_formType==FormType.login ? moveToRegister:moveToLogin),
              )
            ],
          ),
        ),
      ),
    );
  }
}