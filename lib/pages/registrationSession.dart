import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:psifi/utils/thumbnail.dart';
import 'package:psifi/widgets/Registrations.dart' as prefix1;
import 'package:psifi/widgets/registrations.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// how to link the csv data stream with this?
// lets keep them sperate for now
// create a class that takes in
// field type to construt a widget
//
class RegistrationsSession extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegistrationsSessionState();
}

class RegistrationsSessionState extends State<RegistrationsSession> {
  final formKey = GlobalKey<FormState>();
  final List<Function> _pages = [];
  int pageNumber = 0;
  int numberOfMember = 0;
  bool pagesLoaded = false;
  int pagesCap = 3;
  @override
  Widget build(BuildContext context) {
    if (!pagesLoaded) {
      _pages.add(page1);
      _pages.add(page2);

      pagesLoaded = true;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: _pages[pageNumber](pageNumber));

    // body: PageViewIndicator(
    //   pageIndexNotifier: ValueNotifier(0),
    //   length: 3,
    //   normalBuilder: (animationController,_) => Circle(
    //     size: 8.0,
    //     color: Colors.black87,
    // ),
    // highlightedBuilder: (animationController,_) => ScaleTransition(
    //   scale: CurvedAnimation(
    //     parent: animationController,
    //     curve: Curves.ease,
    //   ),
    //   child: Circle(
    //     size: 12.0,
    //     color: Colors.black45,
    //   ),
    // ),));
  }

  Widget page1(i) {
    return Material(
        child: Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            child: Form(
                key: formKey,
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 30.0),
                        child: Text("Team/School Information",
                            style: TextStyle(fontSize: 25))),

                    // DateCustomField("Date Of Birth"),
                    DropdownCustomField('Are you applying through ______ ?',
                        null, ['School', 'University', 'Privately'], (val) {}),
                    DropdownCustomField('Team Members', '3', ['3', '4', '5'],
                        (val) {
                      numberOfMember = int.parse(val);
                      for (int i = 0; i < numberOfMember; i++) {
                        _pages.add(member);
                      }
                    }),
                    DropdownCustomField(
                        'Will a Faculty Adviser accompany you to LUMS?',
                        'Y',
                        ['Y', 'N'],
                        (val) {}),
                    Text('Faculty Advisor Form: ## WILL BE ADDED LATER'),
                    textField("Institution Name", (value) {},
                        TextInputType.multiline),
                    textField("Institution City", (value) {},
                        TextInputType.multiline),
                    textField("Institution Email", (value) {},
                        TextInputType.emailAddress),
                    textField("Principal Email Address", (value) {},
                        TextInputType.emailAddress),
                    textField("Institution Phone Number", (value) {},
                        TextInputType.phone),
                    textField(
                        "Complete Address Of Institution",
                        (value) {},
                        TextInputType
                            .multiline), // break this into smaller sections like on cofnito
                    navButtons()
                  ],
                )))));
  }

  Widget navButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        pageNumber > 0
            ? Expanded(
                child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text("Back"),
                    onPressed: () {
                      setState(() {
                        pageNumber -= 1;
                      });
                    }))
            : SizedBox(),
        Expanded(
            child: RaisedButton(
          color: Theme.of(context).accentColor,
          child: Text(pageNumber < _pages.length - 1 ? "Next" : "Finish"),
          onPressed: () {
            FormState formState = formKey.currentState;
            if (formState.validate()) {
              formState.save();
              if (pageNumber < _pages.length - 1)
                setState(() {
                  pageNumber += 1;
                });
              else
                print("finish");
            } else
              print("hi");
          },
        ))
      ],
    );
  }

  Widget page2(i) {
    return Material(
        child: Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            child: Form(
                key: formKey,
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 30.0),
                        child: Text("Head Delegate",
                            style: TextStyle(fontSize: 25))),
                    heading("Picture"),
                    showImage(),
                    imageField("Upload"),
                    helpText("Max File Size Allowed 3MB"),
                    Container(
                        margin: EdgeInsets.only(bottom: 10.0, top: 15),
                        child: Text(
                          "Name",
                          style: TextStyle(fontSize: 15),
                        )),
                    textField("First Name", (value) {}, TextInputType.text),
                    textField("Last Name", (value) {}, TextInputType.text),
                    DateCustomField("Date Of Birth"),
                    DropdownCustomField('Gender', null, ['M', 'F'], (val) {}),
                    DropdownCustomField(
                        'Accomodation', null, ['Y', 'N'], (val) {}),
                    heading('Mobile Number'),
                    textField("Number", (value) {}, TextInputType.phone),
                    Container(
                        margin: EdgeInsets.only(bottom: 10.0, top: 15),
                        child: Text(
                          "Address",
                          style: TextStyle(fontSize: 15),
                        )),
                    textField(
                        "Address Line 1", (value) {}, TextInputType.multiline),
                    textField("City", (value) {}, TextInputType.text),
                    textField("Country", (value) {}, TextInputType.text),
                    heading("CNIC/B-Form Number"),
                    textField("Number", (value) {}, TextInputType.number),
                    heading("Email Address"),
                    textField("@", (value) {}, TextInputType.emailAddress),
                    heading("Gaurdian"),
                    textField("First Name", (value) {}, TextInputType.text),
                    textField("Last Name", (value) {}, TextInputType.text),
                    textField("Mobile Number", (value) {}, TextInputType.phone),
                    heading("Waiver Of Liability"),
                    imageField("Upload"),
                    helpText(
                        "Please download the waiver of liability form from the website. Print and sign it and upload the picture of signed form here. Image should in jpeg or jpg with maximum allowed size of 500 KB."),
                    heading("Waiver Of Liability-Accommodation"),
                    imageField("Upload"),
                    helpText(
                        "Please download the waiver of liability form (for accommodation) from the website. Print and sign it and upload the picture of signed form here. Image should in jpeg or jpg with maximum allowed size of 500 KB."),
                    navButtons()
                  ],
                )))));
  }

  Widget member(int memberNumber) {
    return Material(
        child: Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            child: Form(
                key: formKey,
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 30.0),
                        child: Text("Member ${memberNumber}",
                            style: TextStyle(fontSize: 25))),
                    heading("Picture"),
                    showImage(),
                    imageField("Upload"),
                    helpText("Max File Size Allowed 3MB"),
                    Container(
                        margin: EdgeInsets.only(bottom: 10.0, top: 15),
                        child: Text(
                          "Name",
                          style: TextStyle(fontSize: 15),
                        )),
                    textField("First Name", (value) {}, TextInputType.text),
                    textField("Last Name", (value) {}, TextInputType.text),
                    DateCustomField("Date Of Birth"),
                    DropdownCustomField('Gender', null, ['M', 'F'], (val) {}),
                    DropdownCustomField(
                        'Accommodation', null, ['Y', 'N'], (val) {}),
                    heading('Mobile Number'),
                    textField("Number", (value) {}, TextInputType.phone),
                    Container(
                        margin: EdgeInsets.only(bottom: 10.0, top: 15),
                        child: Text(
                          "Address",
                          style: TextStyle(fontSize: 15),
                        )),
                    textField(
                        "Address Line 1", (value) {}, TextInputType.multiline),
                    textField("City", (value) {}, TextInputType.text),
                    textField("Country", (value) {}, TextInputType.text),
                    heading("CNIC/B-Form Number"),
                    textField("Number", (value) {}, TextInputType.number),
                    heading("Email Address"),
                    textField("@", (value) {}, TextInputType.emailAddress),
                    heading("Gaurdian"),
                    textField("First Name", (value) {}, TextInputType.text),
                    textField("Last Name", (value) {}, TextInputType.text),
                    textField("Mobile Number", (value) {}, TextInputType.phone),
                    heading("Waiver Of Liability"),
                    imageField("Upload"),
                    helpText(
                        "Please download the waiver of liability form from the website. Print and sign it and upload the picture of signed form here. Image should in jpeg or jpg with maximum allowed size of 500 KB."),
                    heading("Waiver Of Liability-Accommodation"),
                    imageField("Upload"),
                    helpText(
                        "Please download the waiver of liability form (for accommodation) from the website. Print and sign it and upload the picture of signed form here. Image should in jpeg or jpg with maximum allowed size of 500 KB."),
                    navButtons()
                  ],
                )))));
  }

  Future<File> imageFile;
  Widget imageField(String label) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: () {
        setState(() {
          imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
          imageFile.then((e) {
            imageFile = thumbnail(e);
          });
        });
      },
      child: Text(label),
    );
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return prefix0.Image.file(
            snapshot.data,
            fit: BoxFit.contain,
          );
        } else {
          return prefix0.Image.file(
            File('${Directory.systemTemp.path}/thumbnail.png'),
          );
        }
      },
    );
  }
}
