import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
// This file contains widgets for use in the registration session.

// todo : create a dictionary that stores variables and then send it of to a file for resuming
Widget heading(String label) {
  return Container(
      margin: EdgeInsets.only(bottom: 10.0, top: 15),
      child: Text(
        label,
        style: TextStyle(fontSize: 15),
      ));
}

Widget helpText(String label) {
  return Container(
    child: Text(
      label,
      style: TextStyle(fontSize: 8, color: Colors.black45),
    ),
  );
}

Widget textField(String label, Function callback,String initial, TextInputType keyboardType) {
  return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
          initialValue: initial,
          decoration: InputDecoration(
            labelText: label,
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderSide: new BorderSide(),
            ),
          ),
          validator: (val) {
            if (val.length == 0) {
              return "Required";
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
  final String _initial;
  final Function _callback;
  DateCustomField(this._label,this._initial,this._callback);
  @override
  State<StatefulWidget> createState() {
    return DateCustomFieldState();
  }
}

class DateCustomFieldState extends State<DateCustomField> {
  DateTime selectedDate;
  var formatter = new DateFormat('dd/MM/yyyy');
  @override
  void initState() {
    super.initState();
    selectedDate = (widget._initial == null)?DateTime(1997):widget._initial;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: InkWell(
          onTap: () => selectDate(context).then((e) {
            if (e != null)
              setState(() {
                widget._callback(e);
                selectedDate = e;
              });
          }),
          child: InputDecorator(
            decoration: InputDecoration(
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
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        },
      );
}

class DropdownCustomField extends StatefulWidget {
  final List<String> _options;
  final String _option;
  final String _label;
  final Function _func;
  DropdownCustomField(this._label, this._option, this._options, this._func);

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
    print(currOption);
  }

  @override
  Widget build(BuildContext context) {
    bool isError = false;
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: FormField(
          onSaved: widget._func,
          initialValue: currOption,
          validator: (value) {
            if (value == null) {
              isError = true;
              return "Required";
            } else
              return null;
          },
          builder: (FormFieldState state) {
            return InputDecorator(
              decoration: InputDecoration(
                  errorText: (isError)?"This cannot be empty":null,
                  labelText: widget._label,
                  labelStyle: TextStyle()),
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
