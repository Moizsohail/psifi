import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialRedirectPage extends StatefulWidget{
  SocialRedirectPage(); //empty constructor body

  @override
  State<StatefulWidget> createState() => SocialRedirectPageState();
}

class SocialRedirectPageState extends State<SocialRedirectPage>{
            
  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 380,
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                SocialButton(socialURL: "https://www.facebook.com/LUMSPsiFi", socialIcon: new Icon(FontAwesomeIcons.facebookF), socialColor: Color.fromRGBO(59,89,152, 1)),
                SocialButton(socialURL: "https://www.instagram.com/lumspsifi", socialIcon: new Icon(FontAwesomeIcons.instagram), socialColor: Colors.black),
                SocialButton(socialURL: "https://spades.lums.edu.pk/PSIFI/index.html", socialIcon: new Icon(FontAwesomeIcons.globe), socialColor: Colors.green),
                SocialButton(socialURL: "https://twitter.com/lumspsifi?lang=en", socialIcon: new Icon(FontAwesomeIcons.twitter), socialColor: Color.fromRGBO(29, 202, 255, 1)),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {launch("http://spades.lums.edu.pk/portal/login.html");},
            textColor: Colors.white,
            padding: EdgeInsets.only(),
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF800000),
                    Color(0xFFDE8181),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PSIFI XI Registration Portal',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 10.0),
                  Icon(
                    FontAwesomeIcons.externalLinkSquareAlt
                  ),
                ],
              )
            ),
          ),
        ],
      )
    );
  }
}


class SocialButton extends StatelessWidget {
  SocialButton({this.socialURL, this.socialIcon, this.socialColor});

  final Icon socialIcon;
  final String socialURL;
  final Color socialColor;
  
  @override
  Widget build(BuildContext context){
    return new Container(
        padding: EdgeInsets.all(5.0),
        child: Ink(
        color: socialColor,
        child: IconButton(
          icon: socialIcon,
          iconSize: 70.0,
          color: Colors.white,
          onPressed: () {
            launch(socialURL);
          },
        ),
      )
    );
  }
}
