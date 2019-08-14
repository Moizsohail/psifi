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
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          SocialButton(socialURL: "https://www.facebook.com/LUMSPsiFi", socialIcon: new Icon(FontAwesomeIcons.facebookF), socialColor: Color.fromRGBO(59,89,152, 1)),
          SocialButton(socialURL: "https://www.instagram.com/lifeatlums", socialIcon: new Icon(FontAwesomeIcons.instagram), socialColor: Colors.black),
          SocialButton(socialURL: "https://spades.lums.edu.pk/PSIFI/index.html", socialIcon: new Icon(FontAwesomeIcons.globe), socialColor: Colors.green),
          SocialButton(socialURL: "https://twitter.com/lumspsifi?lang=en", socialIcon: new Icon(FontAwesomeIcons.twitter), socialColor: Color.fromRGBO(29, 202, 255, 1)),
        ],
      ),
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
