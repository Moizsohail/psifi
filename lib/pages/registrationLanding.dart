import 'package:flutter/material.dart';
import 'package:psifi/pages/registrationSession.dart';
import 'package:psifi/utils/formDataRecorder.dart';

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
  FormDataRecorder formdatarecorder;
  bool showLoading;
  bool showResumeButton;
  RegistrationState _registrationState =
      RegistrationState.ongoing_registration_new;
  @override
  void initState() {
    super.initState();
    showResumeButton = false;
    formdatarecorder = FormDataRecorder();
    formdatarecorder.isExist().then((isExist){
      if (isExist)
        setState((){
          showResumeButton = true;
        });
    }
    );
    showLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (_registrationState == RegistrationState.closed_registration)
            ? closedRegistration()
            : ongoingRegistration());
  }

  Widget closedRegistration() => Column(
        children: <Widget>[
          Text("Sorry The Registartion Has Ended"),
        ],
      );

  Widget ongoingRegistration() {
    
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Text Obtained from the server"),
          RaisedButton(
            onPressed: (_registrationState ==
                    RegistrationState.ongoing_registration_new)
                ? () {
                    setState(() {
                     showLoading = true; 
                    });
                    formdatarecorder.read().then((result) {
                      setState(() {
                       showLoading = false; 
                      });
                      if (result != null)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegistrationsSession(result)));
                    });
                  }
                : null,
            color: Theme.of(context).accentColor,
            child: (showLoading)?CircularProgressIndicator():Text(
              "Resume",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          FlatButton(
            child: Text("New"),
            onPressed: () {
              formdatarecorder.createNew();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrationsSession({'a': 'a'})));
            },
          )
        ],
      ),
    );
  }
}
