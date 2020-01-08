import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utils/mappings.dart';
import 'utils/authentication.dart';
//import 'pages/temp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //ROOT
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PSIFI XI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff060e66),
          accentColor: Colors.white,
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          primaryIconTheme: IconThemeData(color: Colors.redAccent[100]),
          appBarTheme: AppBarTheme(color: Color(0xff060e66)),
          bottomAppBarColor: Colors.red),
      //home: Temp(), google maps test
      home: MessageHandler(Mappings(Auth())),
    );
  }
}

class MessageHandler extends StatefulWidget {
  final Widget _widget;
  MessageHandler(this._widget);
  @override
  State<StatefulWidget> createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _fcm.subscribeToTopic('all');
    _fcm.configure(
      onMessage: (message) async {
        print("onMessage: $message");
        final snackbar = SnackBar(
          content: Text(message['notification']['title']),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      },
      onResume: (message) async {
        print("onResume: $message");
      },
      onLaunch: (message) async {
        print("onLaunch: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget._widget;
  }
}
