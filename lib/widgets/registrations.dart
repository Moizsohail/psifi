import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
// This file contains widgets for use in the registration session.


// create a dictionary that stores variables and then send it of to a file for resuming
Widget imageField(String label,Function getImage){
  return RaisedButton(
    onPressed: ()async{
      
      var galleryFile = await ImagePicker.pickImage(source:ImageSource.gallery);
    },
    child: Text("Pick Image"),
  );
}

Widget textField(String label, Function callback, TextInputType keyboardType) {
  return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
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
          keyboardType: keyboardType,
          style: new TextStyle(
            fontFamily: "Poppins",
          ),
          onSaved: callback));
}

class DateCustomField extends StatefulWidget {
  final String _label;
  DateCustomField(this._label);
  @override
  State<StatefulWidget> createState() {
    return DateCustomFieldState();
  }
}

class DateCustomFieldState extends State<DateCustomField> {
  DateTime selectedDate = DateTime(1997);
  var formatter = new DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: InkWell(
          onTap: () => selectDate(context).then((e) {
                if (e != null)
                  setState(() {
                    selectedDate = e;
                  });
              }),
          child: new InputDecorator(
            decoration: new InputDecoration(
              labelText: widget._label,
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(formatter.format(selectedDate)),
                new Icon(Icons.arrow_drop_down,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade700
                        : Colors.white70),
              ],
            ),
          ),
        ));
  }

  Future<DateTime> selectDate(BuildContext context) async =>
      await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1994),
        lastDate: DateTime(2010),
        builder: (BuildContext context, Widget child) {
          return FittedBox(
              child: Theme(
            data: ThemeData.dark(),
            child: child,
          ));
        },
      );
}

class DropdownCustomField extends StatefulWidget {
  final List<String> _options;
  final String _option;
  final String _label;
  DropdownCustomField(this._label, this._option, this._options);
  @override
  State<StatefulWidget> createState() {
    return DropdownCustomFieldState();
  }
}

class DropdownCustomFieldState extends State<DropdownCustomField> {
  String currOption;
  @override
  void initState() {
    super.initState();
    currOption = widget._option;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
              labelText: widget._label, labelStyle: TextStyle()),
          isEmpty: currOption == '',
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: currOption,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  currOption = newValue;
                  state.didChange(newValue);
                });
              },
              items: widget._options.map((String value) {
                return new DropdownMenuItem(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    ));
  }
}
