import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psifi/utils/authentication.dart';

class NotificationAdmin extends StatefulWidget{
  final AuthImplementation _auth;
  final DocumentSnapshot _doc;
  final bool _edit;
  NotificationAdmin(this._auth, this._doc,this._edit);
  @override
  State<StatefulWidget> createState() => NotificationAdminState();
}

class NotificationAdminState extends State<NotificationAdmin>{
  var _form = GlobalKey<FormState>();
  String _title = "";
  String _message = "";
  String _url = "";
  bool _submitted = false;
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._edit?"Edit \"${widget._doc['Description']}\"":"Add"),
      ),
      body: Form(
        key: _form,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child:  ListView(
           // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildTextFormField('Title',(val)=>_title=val),
              buildTextFormField('Description',(val)=>_message=val),
              buildTextFormField('URL',(val)=>_url=val),
              SizedBox(height: 10),
              RaisedButton(
                child: Text(
                  _submitted?"Submitted":"Submit",
                  style: TextStyle(color: Colors.white)),
                color:Colors.redAccent[100], 
                onPressed: (){
                  if(widget._edit){
                    return _submitted?null:updateData;
                  }
                    return _submitted?null:createData;
                }()
              ),          
            ],
          ),
        )
      ),
    );
  }
  
  TextFormField buildTextFormField(String text,Function onSaved){
    return TextFormField(
      initialValue: widget._edit ? widget._doc[text]:null,
      decoration: InputDecoration(
        hintText: text,
      ),
      maxLines: text == "Description" ? null:1,
      validator: (value){
        if (value.isEmpty && text != "URL") { //URLs may be left empty
          return 'Required';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
  
  void updateData() async{
    if(_form.currentState.validate()){
      _form.currentState.save();
      setState(() { _submitted = true; });
      await Firestore.instance.
        collection('Notifications').
        document(widget._doc.documentID).
        updateData({
        'Title':_title,
        'Description':_message,
        'URL':_url,
        'Priority':widget._doc['Priority'],
        'PublisherId':widget._doc['PublisherId'],
        'PostTime':widget._doc['PostTime']
        });
      Navigator.of(context).pop();
    }
  }
  
  void createData() async{
    if (_form.currentState.validate()){
      _form.currentState.save();
      setState((){
        _submitted=true;
      });
      await Firestore.instance.collection('Notifications').add({
        'Title': _title,
        'Description': _message,
        'URL':_url,
        'Priority': 1,
        'PublisherId':await widget._auth.getCurrentUserUID(),
        'PostTime': DateTime.now()
      });
      Navigator.of(context).pop();
    }
  }
}