import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:psifi/utils/firestorehelper.dart';
import '../utils/authentication.dart';
import 'package:flutter/material.dart';
//import 'notificationadmin.dart';

class LoginRegisterPage extends StatefulWidget {
  //stateful
  final AuthImplementation _auth;
  final VoidCallback _onLoggedIn;
  LoginRegisterPage(this._auth, this._onLoggedIn); //constructor
  @override
  State<StatefulWidget> createState() => LoginRegisterPageState();
}

//enums for state toggles
enum FormType { login, register }
enum LoginButtonState { normal, loading, success, error }

class LoginRegisterPageState extends State<LoginRegisterPage> {
  bool passwordHidden;
  LoginButtonState _loginButtonState =
      LoginButtonState.normal; //normal initially
  final formKey = GlobalKey<FormState>();
  // final FirebaseMessaging _messaging =
      // FirebaseMessaging(); //firebase messaging object created
  FirestoreHelper _firestore = FirestoreHelper(
      "pushtokens"); //helper functions for pushtokens collection

  // void fireMessagingListeners() {
  //   //requestNotificationsPermissions?
  //   _messaging.configure(
  //       //Firebase MessageHandler setup, functions to perform on specific actions
  //       onMessage: (message) async => print('onMessage $message'),
  //       onResume: (message) async => print('onResume $message'),
  //       onLaunch: (message) async =>
  //           print('onLaunch $message')); //simply printing for now
  // }

  FormType _formType = FormType.login; //login form initially
  String _email = "", _password = "";

  //final FirestoreHelper _firestore = FirestoreHelper("pushCodes"); //push codes collection helper
  @override
  void initState() {
    super.initState();
    passwordHidden = true;
    // _messaging.getToken().then((token) {
    //   print(token);
    //   _firestore
    //       .addUniqueData({"devtoken": token}, "devtoken"); //adding a devtoken
    // });
    // fireMessagingListeners(); //firebase messaging listeners setup
  }

  Widget loginBtn() {
    //dynamic flare animated login btn widget, plays anim on state change
    switch (_loginButtonState) {
      case LoginButtonState
          .normal: // Display centered text Login/Register depending on the current FormType
        return Center(
            child: Text(
          _formType == FormType.login ? "Login" : "Register",
          style: TextStyle(
              color: _formType == FormType.login
                  ? Theme.of(context).accentColor
                  : Theme.of(context).primaryColor),
        ));

      default:
        return Container(
          height: 40,
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: FlareActor(
            "animations/loadingandok.flr",
            fit: BoxFit.contain,
            //olor: Colors.white,
            animation: _loginButtonState == LoginButtonState.loading
                ? "loading"
                : _loginButtonState == LoginButtonState.success
                    ? "ok"
                    : "error",
          ),
        );
        break;
    }
  }

  void validateAndSubmit() {
    setState(() => _loginButtonState = LoginButtonState
        .loading); //loading state while given credentials are being validated and processed

    if (validateAndSave()) {
      switch (_formType) {
        case FormType.login:
          widget._auth.signIn(_email, _password).then((e) {
            setState(() => _loginButtonState =
                LoginButtonState.success); //on successful sign in
            widget._onLoggedIn();
          }).catchError((e) {
            final snackBar = SnackBar(
                content: Text(e.message,
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                backgroundColor: Theme.of(context).accentColor);
            Scaffold.of(context).showSnackBar(snackBar);

            setState(() => _loginButtonState = LoginButtonState.error);
            print("Error validating login form data: ${e.toString()}"); //HAHAH
            setState(() => _loginButtonState = LoginButtonState.normal);
          });
          break;

        case FormType.register:
          widget._auth
              .signUp(_email, _password)
              .then((e) => widget._onLoggedIn())
              .catchError((e) {
            final snackBar = SnackBar(
              content: Text(e.message,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  )),
              backgroundColor: Theme.of(context).primaryColor,
            );
            Scaffold.of(context).showSnackBar(snackBar);

            setState(() => _loginButtonState = LoginButtonState.error);
          });
          break;
      }
    }
  }

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    
    if (form.validate()) {
      form.save(); //save and return true on successful form validation
      return true;
    }
    return false;
  }

  void moveToLogin() {
    formKey.currentState.reset(); //reset form state
    setState(() {
      _formType = FormType.login;
    }); //formType set to login
  }

  void moveToRegister() {
    //switch to registration/signUp page
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
            _formType == FormType.login
                ? "PSIFI-XI Login"
                : "PSIFI-XI Register",
            style: TextStyle(
                color: _formType == FormType.login
                    ? Theme.of(context).accentColor
                    : Theme.of(context).primaryColor)),
        backgroundColor: _formType == FormType.login
            ? Theme.of(context).primaryColor
            : Theme.of(context).accentColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          //key,child,autovalidate,onWillPop,onChanged
          key: formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30), //sort of padding, empty sizedbox

              TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Enter Email",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Email should not be empty.";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onSaved: (value) {
                    print(value);
                    return _email = value;
                  }),

              SizedBox(height: 10),

              TextFormField(
                  decoration: new InputDecoration(
                    suffixIcon:IconButton(icon:(passwordHidden?Icon(Icons.visibility):Icon(Icons.visibility_off)),
                    onPressed: () =>setState(() {
                     passwordHidden = !passwordHidden; 
                    })),
                    
                    labelText: "Enter Password",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Password should not be empty.";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                    fontFamily: "Poppins",

                  ),
                  obscureText: passwordHidden,
                  onSaved: (value) {
                    return _password = value;
                  }),

              SizedBox(height: 10),

              RaisedButton(
                //main login button
                color: _formType == FormType.login
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 30.0,
                  child: loginBtn(),
                ),
                onPressed: validateAndSubmit,
              ),

              FlatButton(
                //Form state toggle button
                //Text to display depending on the form selected.
                child: Text(_formType == FormType.login
                    ? "Don't Have An Account? Register"
                    : "Already Have An Account? Login"),
                onPressed: (_formType == FormType.login
                    ? moveToRegister
                    : moveToLogin), //toggle form state by the moveTo functions
              )
            ],
          ),
        ),
      ),
    );
  }
}
