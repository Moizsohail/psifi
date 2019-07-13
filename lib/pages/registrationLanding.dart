import 'package:flutter/material.dart';
import 'package:psifi/pages/registrationSession.dart';

class RegistrationLanding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegistrationLandingState();
}
///// NOTE:: ANY CHANGES MADE TO THE RegistrationForm Needs to be reflected in the csvReaders create function.

enum RegistrationState {
  closed_registration,
  ongoing_registration_resume,
  ongoing_registration_new
}

class RegistrationLandingState extends State<RegistrationLanding> {
  RegistrationState _registrationState =
      RegistrationState.ongoing_registration_new;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (_registrationState == RegistrationState.closed_registration)
            ? closedRegistration()
            : ongoingRegistration());
  }

  Widget closedRegistration() {
    return Column(
      children: <Widget>[
        Text("Sorry The Registartion Has Ended"),
      ],
    );
  }

  Widget ongoingRegistration() {
    return Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Text Obtained from the server"),
        RaisedButton(
          onPressed:
              (_registrationState == RegistrationState.ongoing_registration_new)
                  ? null
                  : () {},
          color: Theme.of(context).accentColor,
          child: Text("Resume",style: TextStyle(color: Theme.of(context).primaryColor),),
        ),
        FlatButton(
          child: Text("Start Afresh"),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationsSession()));
          },
        )
      ],
    ),);
  }
}
