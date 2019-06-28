import 'package:flutter/material.dart';
import 'package:psifi/widgets/registrations.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

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
  List<Widget> _pages = [];
  @override
  void initState() {
    super.initState();
    _pages.add(page1());
    _pages.add(page1());
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: PageView.builder(
          itemBuilder: (context, position) {
            return _pages[position];
          },
          itemCount: _pages.length,
        ));
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

  Widget page1() {
    return Container(
        padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
        child: ListView(
          children: <Widget>[
            textField("First Name", (value) {}, TextInputType.text),
            textField("Last Name", (value) {}, TextInputType.text),
            DateCustomField("Date Of Birth"),
            DropdownCustomField('a',['a','c'])
          ],
        ));
  }
}
