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
class LoginRegisterPageState extends State<LoginRegisterPage>{
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";
  void validateAndSubmit(){
    if (validateAndSave()){
      switch(_formType){
        case FormType.login:
          widget._auth.SignIn(_email,_password).then((e)=>
            widget._onLoggedIn()
          ).catchError((e)=>print("ERROR YO BITCH ${e.toString()}"));
          
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
    if (form.validate())
      form.save();
      return true;
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
                obscureText: true,
                onSaved: (value){
                  return _password = value;
                }
              ),
              SizedBox(height: 10,),
              RaisedButton(
                padding: EdgeInsets.all(5),
                child: Text(_formType==FormType.login ? "Login": "Register"),
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