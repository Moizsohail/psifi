import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:psifi/utils/formDataRecorder.dart';
import 'package:psifi/utils/thumbnail.dart';
import 'package:psifi/widgets/registrations.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// how to link the csv data stream with this?
// lets keep them sperate for now
// create a class that takes in
// field type to construt a widget
//

/* create a drictonary
issues looks like a better option
will need a key for every entry
will store data into it
will retrieve data on creation
// create a list
issues
will require max to initialize

*/
Map<String, dynamic> data;

class RegistrationsSession extends StatefulWidget {
  final Map<String, dynamic> _data;
  RegistrationsSession(this._data);
  @override
  State<StatefulWidget> createState() => RegistrationsSessionState();
}

class RegistrationsSessionState extends State<RegistrationsSession> {
  List<GlobalKey<FormState>> formKey = [];
  final List<Function> _pages = [];
  FormDataRecorder _formDataRecorder;
  int pageNumber = 0;
  int numberOfMember = 0;
  bool pagesLoaded = false;
  int pagesCap = 3;
  @override
  void initState() {
    super.initState();
    //List<String> allKeys = data.keys.toList();
    _formDataRecorder = FormDataRecorder();
    data = widget._data;
    for (int i = 0; i < 8; i++) {
      formKey.add(GlobalKey<FormState>());
    }
  }

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
    print(data);
    return Material(
        child: Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            child: Form(
                key: formKey[i],
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 30.0),
                        child: Text("Team/School Information",
                            style: TextStyle(fontSize: 25))),

                    // DateCustomField("Date Of Birth"),
                    DropdownCustomField(
                        'Are you applying through ______ ?',
                        data['applyingthrough'],
                        ['School', 'University', 'Privately'], (val) {
                      data['applyingthrough'] = val;
                    }),
                    DropdownCustomField('Team Members', data['numberofmembers'],
                        ['3', '4', '5'], (val) {
                      data['numberofmembers'] = val;
                      numberOfMember = int.parse(val) -
                          1; // -1 because head delegate is double counted otherwise
                      const int unitializedPageStack = 2;
                      int recommendedPageStack = 2 + numberOfMember + 2;
                      print("hi" + _pages.length.toString());
                      if (recommendedPageStack != _pages.length) {
                        for (int i = 0; unitializedPageStack != _pages.length; i++) {
                          _pages.removeLast();
                        }
                      }
                      if (unitializedPageStack == _pages.length) {
                        for (int i = 0; i < numberOfMember; i++) {
                          _pages.add(member);
                        }
                        _pages.add(eventPage);
                        _pages.add(confirmationPage);
                      }
                      print("BYE" + _pages.length.toString());
                    }),
                    DropdownCustomField(
                        'Will a Faculty Adviser accompany you to LUMS?',
                        data['faculty'],
                        ['Y', 'N'], (val) {
                      data['faculty'] = val;
                    }),
                    Text('Faculty Advisor Form: ## WILL BE ADDED LATER'),
                    textField("Institution Name", (value) {
                      data['institname'] = value;
                    }, data['institname'], TextInputType.multiline),
                    textField("Institution City", (value) {
                      data['institcity'] = value;
                    }, data['institcity'], TextInputType.multiline),
                    textField("Institution Email", (value) {
                      data['institemail'] = value;
                    }, data['institemail'], TextInputType.emailAddress),
                    textField("Principal Email Address", (value) {
                      data['principalemail'] = value;
                    }, data['principalemail'], TextInputType.emailAddress),
                    textField("Institution Phone Number", (value) {
                      data['institphonenumber'] = value;
                    }, data['institphonenumber'], TextInputType.phone),
                    textField("Complete Address Of Institution", (value) {
                      data['addrofinstit'] = value;
                    },
                        data['addrofinstit'],
                        TextInputType
                            .multiline), // break this into smaller sections like on cofnito
                    navButtons(i)
                  ],
                )))));
  }

  Widget navButtons(i) {
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
            FormState formState = formKey[i].currentState;
            if (formState.validate()) {
              () async {
                formState.save();
              }()
                  .then((onValue) => _formDataRecorder.save(data));

              if (pageNumber < _pages.length - 1)
                setState(() {
                  pageNumber += 1;
                });
              else
                print("finish");
            } else {}
            //print("hi");
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
                key: formKey[i],
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 30.0),
                        child: Text("Head Delegate",
                            style: TextStyle(fontSize: 25))),
                    heading("Picture"),
                    // showImage(),
                    imageField("Upload", 'img1'),
                    helpText("Max File Size Allowed 3MB"),
                    Container(
                        margin: EdgeInsets.only(bottom: 10.0, top: 15),
                        child: Text(
                          "Name",
                          style: TextStyle(fontSize: 15),
                        )),
                    textField("First Name", (value) {
                      data['fn1'] = value;
                    }, data['fn1'], TextInputType.text),
                    textField("Last Name", (value) {
                      data['ln1'] = value;
                    }, data['ln1'], TextInputType.text),
                    DateCustomField("Date Of Birth", data['dob1'],
                        (DateTime val) {
                      data['dob1'] = val.toIso8601String();
                    }),
                    DropdownCustomField('Gender', data['gender1'], ['M', 'F'],
                        (val) {
                      data['gender1'] = val;
                    }),
                    DropdownCustomField(
                        'Accomodation', data['accom1'], ['Y', 'N'], (val) {
                      data['accom1'] = val;
                    }),
                    heading('Mobile Number'),
                    textField("Number", (value) {
                      data['nm1'] = value;
                    }, data['nm1'], TextInputType.phone),
                    Container(
                        margin: EdgeInsets.only(bottom: 10.0, top: 15),
                        child: Text(
                          "Address",
                          style: TextStyle(fontSize: 15),
                        )),
                    textField("Address Line 1", (value) {
                      data['addrln1'] = value;
                    }, data['addrln1'], TextInputType.multiline),
                    textField("City", (value) {
                      data['city1'] = value;
                    }, data['city1'], TextInputType.text),
                    textField("Country", (value) {
                      data['country1'] = value;
                    }, data['country1'], TextInputType.text),
                    heading("CNIC/B-Form Number"),
                    textField("Number", (value) {
                      data['cnic1'] = value;
                    }, data['cnic1'], TextInputType.number),
                    heading("Email Address"),
                    textField("@", (value) {
                      data['emailaddr1'] = value;
                    }, data['emailaddr1'], TextInputType.emailAddress),
                    heading("Gaurdian"),
                    textField("First Name", (value) {
                      data['gaurdianfn1'] = value;
                    }, data['gaurdianfn1'], TextInputType.text),
                    textField("Last Name", (value) {
                      data['gaudrianlna1'] = value;
                    }, data['gaudrianlna1'], TextInputType.text),
                    textField("Mobile Number", (value) {
                      data['gaudrainnm1'] = value;
                    }, data['gaudrainnm1'], TextInputType.phone),
                    heading("Waiver Of Liability"),
                    imageField("Upload", 'img2'),
                    helpText(
                        "Please download the waiver of liability form from the website. Print and sign it and upload the picture of signed form here. Image should in jpeg or jpg with maximum allowed size of 500 KB."),
                    heading("Waiver Of Liability-Accommodation"),
                    imageField("Upload", 'img3'),
                    helpText(
                        "Please download the waiver of liability form (for accommodation) from the website. Print and sign it and upload the picture of signed form here. Image should in jpeg or jpg with maximum allowed size of 500 KB."),
                    navButtons(i)
                  ],
                )))));
  }

  Widget member(int memberNumber) {
    print('gendera' + memberNumber.toString());
    return Material(
        child: Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            child: Form(
                key: formKey[memberNumber],
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 30.0),
                        child: Text("Member $memberNumber",
                            style: TextStyle(fontSize: 25))),
                    heading("Picture"),
                    // showImage(),
                    imageField("Upload", 'img4' + memberNumber.toString()),
                    helpText("Max File Size Allowed 3MB"),
                    Container(
                        margin: EdgeInsets.only(bottom: 10.0, top: 15),
                        child: Text(
                          "Name",
                          style: TextStyle(fontSize: 15),
                        )),
                    textField("First Name", (value) {
                      data['fnm' + memberNumber.toString()] = value;
                    }, data['fnm' + memberNumber.toString()],
                        TextInputType.text),
                    textField("Last Name", (value) {
                      data['lnm' + memberNumber.toString()] = value;
                    }, data['lnm' + memberNumber.toString()],
                        TextInputType.text),
                    DateCustomField(
                        "Date Of Birth", data['doba' + memberNumber.toString()],
                        (DateTime val) {
                      data['doba' + memberNumber.toString()] =
                          val.toIso8601String();
                    }),
                    DropdownCustomField(
                        'Gender',
                        data['gendera' + memberNumber.toString()],
                        ['M', 'F'], (val) {
                      data['gendera' + memberNumber.toString()] = val;
                    }),
                    DropdownCustomField(
                        'Accommodation',
                        data['accoma' + memberNumber.toString()],
                        ['Y', 'N'], (val) {
                      data['accoma' + memberNumber.toString()] = val;
                    }),
                    heading('Mobile Number'),
                    textField("Number", (value) {
                      data['nma' + memberNumber.toString()] = value;
                    }, data['nma' + memberNumber.toString()],
                        TextInputType.phone),
                    Container(
                        margin: EdgeInsets.only(bottom: 10.0, top: 15),
                        child: Text(
                          "Address",
                          style: TextStyle(fontSize: 15),
                        )),
                    textField("Address Line 1", (value) {
                      data['addrlnc' + memberNumber.toString()] = value;
                    }, data['addrlnc' + memberNumber.toString()],
                        TextInputType.multiline),
                    textField("City", (value) {
                      data['cityk' + memberNumber.toString()] = value;
                    }, data['cityk' + memberNumber.toString()],
                        TextInputType.text),
                    textField("Country", (value) {
                      data['countryl' + memberNumber.toString()] = value;
                    }, data['countryl' + memberNumber.toString()],
                        TextInputType.text),
                    heading("CNIC/B-Form Number"),
                    textField("Number", (value) {
                      data['cnicnumberd' + memberNumber.toString()] = value;
                    }, data['cnicnumberd' + memberNumber.toString()],
                        TextInputType.number),
                    heading("Email Address"),
                    textField("@", (value) {
                      data['emailaddressd' + memberNumber.toString()] = value;
                    }, data['emailaddressd' + memberNumber.toString()],
                        TextInputType.emailAddress),
                    heading("Gaurdian"),
                    textField("First Name", (value) {
                      data['fnd' + memberNumber.toString()] = value;
                    }, data['fnd' + memberNumber.toString()],
                        TextInputType.text),
                    textField("Last Name", (value) {
                      data['lnd' + memberNumber.toString()] = value;
                    }, data['lnd' + memberNumber.toString()],
                        TextInputType.text),
                    textField("Mobile Number", (value) {
                      data['mnd' + memberNumber.toString()] = value;
                    }, data['mnd' + memberNumber.toString()],
                        TextInputType.phone),
                    heading("Waiver Of Liability"),
                    imageField("Upload", 'img5' + memberNumber.toString()),
                    helpText(
                        "Please download the waiver of liability form from the website. Print and sign it and upload the picture of signed form here. Image should in jpeg or jpg with maximum allowed size of 500 KB."),
                    heading("Waiver Of Liability-Accommodation"),
                    imageField("Upload", 'img6' + memberNumber.toString()),
                    helpText(
                        "Please download the waiver of liability form (for accommodation) from the website. Print and sign it and upload the picture of signed form here. Image should in jpeg or jpg with maximum allowed size of 500 KB."),
                    navButtons(memberNumber)
                  ],
                )))));
  }

  Widget eventPage(i) {
    return Material(
        child: Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            child: Form(
                key: formKey[i],
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 30.0),
                        child:
                            Text("Event Page", style: TextStyle(fontSize: 25))),
                    DropdownCustomField(
                        'Number of events', data['noe'], ['2', '3'], (val) {
                      data['noe'] = val;
                    }),
                    DropdownCustomField('Event Pref #1', data['e1'], [
                      'Rube Goldberg Machine',
                      'Race To Infinity',
                      'Gear Up',
                      'Siege',
                      'Science Crime Busters',
                      'Diagnosis Dilemma',
                      'Galactica',
                      'Math Gauge',
                      'Robowars',
                      'Tour de Mind',
                      'Tech Wars',
                      'Geek Wars',
                      'Zero Gravity'
                    ], (val) {
                      data['e1'] = val;
                    }),
                    DropdownCustomField('Event Pref #2', data['e2'], [
                      'Rube Goldberg Machine',
                      'Race To Infinity',
                      'Gear Up',
                      'Siege',
                      'Science Crime Busters',
                      'Diagnosis Dilemma',
                      'Galactica',
                      'Math Gauge',
                      'Robowars',
                      'Tour de Mind',
                      'Tech Wars',
                      'Geek Wars',
                      'Zero Gravity'
                    ], (val) {
                      data['e2'] = val;
                    }),
                    DropdownCustomField('Event Pref #3', data['e3'], [
                      'Rube Goldberg Machine',
                      'Race To Infinity',
                      'Gear Up',
                      'Siege',
                      'Science Crime Busters',
                      'Diagnosis Dilemma',
                      'Galactica',
                      'Math Gauge',
                      'Robowars',
                      'Tour de Mind',
                      'Tech Wars',
                      'Geek Wars',
                      'Zero Gravity'
                    ], (val) {
                      data['e3'] = val;
                    }),
                    DropdownCustomField('Event Pref #4', data['e4'], [
                      'Rube Goldberg Machine',
                      'Race To Infinity',
                      'Gear Up',
                      'Siege',
                      'Science Crime Busters',
                      'Diagnosis Dilemma',
                      'Galactica',
                      'Math Gauge',
                      'Robowars',
                      'Tour de Mind',
                      'Tech Wars',
                      'Geek Wars',
                      'Zero Gravity'
                    ], (val) {
                      data['e4'] = val;
                    }),
                    DropdownCustomField('Event Pref #5', data['e5'], [
                      'Rube Goldberg Machine',
                      'Race To Infinity',
                      'Gear Up',
                      'Siege',
                      'Science Crime Busters',
                      'Diagnosis Dilemma',
                      'Galactica',
                      'Math Gauge',
                      'Robowars',
                      'Tour de Mind',
                      'Tech Wars',
                      'Geek Wars',
                      'Zero Gravity'
                    ], (val) {
                      data['e5'] = val;
                    }),
                    heading("Explain your choice of events"),
                    textField("TextBox", (value) {
                      data['explaine'] = value;
                    }, data['explaine'], TextInputType.multiline),
                    DateCustomField("Date Of Birth", data['dob0'],
                        (DateTime val) {
                      data['dob0'] = val.toIso8601String();
                    }),
                    DropdownCustomField(
                        'Gender', data['gendere'], ['M', 'F'], (val) {}),
                    DropdownCustomField(
                        'Accommodation', data['accome'], ['Y', 'N'], (val) {}),
                    heading('Mobile Number'),
                    textField("Number", (value) {
                      data['nme'] = value;
                    }, data['nme'], TextInputType.phone),
                    Container(
                        margin: EdgeInsets.only(bottom: 10.0, top: 15),
                        child: Text(
                          "Address",
                          style: TextStyle(fontSize: 15),
                        )),
                    textField("Address Line 1", (value) {
                      data['adlne'] = value;
                    }, data['adlne'], TextInputType.multiline),
                    textField("City", (value) {
                      data['citye'] = value;
                    }, data['citye'], TextInputType.text),
                    textField("Country", (value) {
                      data['countrye'] = value;
                    }, data['countrye'], TextInputType.text),
                    heading("CNIC/B-Form Number"),
                    textField("Number", (value) {
                      data['cnice'] = value;
                    }, data['cnice'], TextInputType.number),
                    heading("Email Address"),
                    textField("@", (value) {
                      data['emailaddre'] = value;
                    }, data['emailaddre'], TextInputType.emailAddress),
                    heading("Gaurdian"),
                    textField("First Name", (value) {
                      data['gaurdiane'] = value;
                    }, data['gaurdiane'], TextInputType.text),
                    textField(
                        "Last Name", (value) {}, null, TextInputType.text),
                    textField(
                        "Mobile Number", (value) {}, null, TextInputType.phone),
                    heading("Waiver Of Liability"),
                    imageField("Upload", 'img7'),
                    helpText(
                        "Please download the waiver of liability form from the website. Print and sign it and upload the picture of signed form here. Image should in jpeg or jpg with maximum allowed size of 500 KB."),
                    heading("Waiver Of Liability-Accommodation"),
                    imageField("Upload", 'img8'),
                    helpText(
                        "Please download the waiver of liability form (for accommodation) from the website. Print and sign it and upload the picture of signed form here. Image should in jpeg or jpg with maximum allowed size of 500 KB."),
                    navButtons(i)
                  ],
                )))));
  }

  Widget confirmationPage(i) {
    return Center(
        child: Column(children: [
      Text("""You have successfully submitted your application. 
          Your team ID is included in the confirmation email sent to the email of the Head Delegate. 
          We will let you know the next steps in your journey to attend Psifi X when Registration Phase 1 is over."""),
      Text("Good Luck!")
    ]));
  }

  Future<File> imageFile;
  Widget imageField(String label, String dataKey) {
    return FormField(
        onSaved: (val) {},
        initialValue: data[dataKey],
        validator: (value) {
          if (data[dataKey] == null) {
            return "Required";
          } else
            return null;
        },
        builder: (FormFieldState state) {
          return RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: () {
              setState(() {
                imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
                imageFile.then((e) {
                  data[dataKey] = thumbnail(e);
                  data[dataKey].then((va) {
                    setState(() {});
                  });
                });
              });
            },
            child: FutureBuilder(
              future: data[dataKey],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.connectionState);
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null)
                  return Text(snapshot.data.path.split('/').removeLast());
                else if (snapshot.connectionState == ConnectionState.waiting)
                  return Text("Uploading");
                else
                  return Text("Upload");
              },
            ),
          );
        });
  }

  // Widget showImage() {
  //   return FutureBuilder<File>(
  //     future: imageFile,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done &&
  //           snapshot.data != null) {
  //         print('here');
  //         return prefix0.Image.file(
  //           snapshot.data,
  //           fit: BoxFit.contain,
  //         );
  //       } else {
  //         return prefix0.Image.file(
  //           File('${Directory.systemTemp.path}/thumbnail.png'),
  //         );
  //       }
  //     },
  //   );
  // }
}
