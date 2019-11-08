import 'package:flutter/material.dart';
import 'eventpage.dart';

class EventDoc {   
  final String title, shortDesc, longDesc, logoImage, eh1, eh2, eh3, eh1Contact, eh2Contact, eh3Contact, eh1Image, eh2Image, eh3Image, coverImage;
  const EventDoc(this.title, this.shortDesc, this.longDesc, this.logoImage, this.eh1, this.eh2, this.eh3, this.eh1Contact, this.eh2Contact, this.eh3Contact, this.eh1Image, this.eh2Image, this.eh3Image, this.coverImage);
}

class EventsPortal extends StatefulWidget{
  EventsPortal(); //empty constructor body

  @override
  State<StatefulWidget> createState() => EventsPortalState();
}

class EventsPortalState extends State<EventsPortal>{
  List<EventDoc> docList = [
    EventDoc('Robo Wars','Learn to equip, equip to fight, fight to defend. Defend the flag with your Battlebot in our Robowars.','Learn to equip, equip to fight, fight to defend. Defend the flag with your Battlebot in our Robowars.','images/robowars.png','Rana Sher Ali','Omair Faqah ur Rehman','NONE','0307 3749589','0302 2113965','NONE','images/eh1_robowars.jpg','images/eh2_robowars.jpg','NONE','images/cover_robowars.png'),
    EventDoc('Diagnosis Dilemma','Teams will be tested on the basis of their medical knowledge and their perseverance under pressure and only those that are able to keep their cool and perform will be able to make it.','Get ready for a unique challenge in this year\'s PsFi: Diagnosis Dilemma; where teams will be tested on the basis of their medical knowledge and their perseverance under pressure and only those that are able to keep their cool and perform will be able to make it.','images/dd.png','Hamza Humayun','Areeba Suhail','NONE','0332 4433986','0320 4334915','NONE','images/eh1_dd.jpg','images/eh2_dd.jpg','NONE','images/cover_dd.png'),
    EventDoc('Drogone','Demonstrate the flight capabilities of your unmanned, electric powered, radio-controlled drone that can best meet the specified mission profile.','TEAMS WILL BRING THEIR OWN DRONES EACH and demonstrate the flight capabilities of an unmanned, electric powered, radio-controlled drone that can best meet the specified mission profile. The goal is a balanced design possessing good demonstrated flight handling qualities and affordable manufacturing requirements while providing high performance. It is the responsibility of the teams to know and follow all provided rules, the FAQs, and all contest day briefings. The winner will not be awarded Best Delegation points but a Cash Prize instead.','images/drogone.png','Ali Adnan Arif','Omair Faqah ur Rehman','Rana Sher Ali','0331 8549269','0302 2113965','0307 3749589','images/eh1_drogone.jpg','images/eh2_drogone.jpg','images/eh3_drogone.jpg','images/cover_drogone.png'),
    EventDoc('Galactica','A glimpse of the future, a race against time! Give the Jetsons a run for their money by reimagining your own utopian space settlement!','A glimpse of the future, a race against time! Give the Jetsons a run for their money by reimagining your own utopian space settlement!','images/galactica.png','Maham Rasheed','Abdul Monum','NONE','0323 1495519','0335 2120631',' ','images/eh1_galactica.jpg','images/eh2_galactica.jpg','NONE','images/cover_galactica.png'),
    EventDoc('Tech Wars','Intense competitions involving ethical hacking, aerospace and reverse engineering where you put your problem solving and debugging skills to the test!','Grab your fellow geeks and prepare for some intense competitions involving ethical hacking, aerospace and reverse engineering where you put your problem solving, debugging and other technical skills to the test! Tech Wars - be ready.','images/techwars.png','Zoraiz Qureshi','Ahmad Humayun','NONE','0331 4385434','0330 4232323','NONE','images/eh1_techwars.jpg','images/eh2_techwars.jpg','NONE','images/cover_techwars.jpg'),
    EventDoc('Science Crime Busters','Use your detective skills and forensic knowledge to eliminate the impossible and unravel the truth.','Use your detective skills and forensic knowledge to eliminate the impossible and unravel the truth.','images/scb.png','Daniyal Tiwana','Zoya Shamsi','NONE','0324 4445553','0344 4443484','NONE','images/eh1_scb.jpg','images/eh2_scb.jpg','NONE','images/cover_scb.png'),
    EventDoc('Scifinity Wars','Brace yourself for the most exciting science fiction event where all you need is a plan of attack for Tha-knows Questions while in Lo ki Wrangle you already have a plan ...attack! Get ready to experience how reality can be whatever you want as you pass the Jericho Missile Test and Handle the Groot.','Brace yourself for the most exciting science fiction event where all you need is a plan of attack for Tha-knows Questions while in Lo ki Wrangle you already have a plan ...attack! Get ready to experience how reality can be whatever you want as you pass the Jericho Missile Test and Handle the Groot.','images/scifinitywars.png','Noor ul Huda Nadeem','Eesha Atif','NONE','0334 0492607','0316 4533005','NONE','images/eh1_scifinitywars.jpg','images/eh2_scifinitywars.jpg','NONE','images/cover_scifinitywars.png'),
    EventDoc('Siege','Build the dreaded war machine of the ancient world, the catapult, aiming to destroy any other pitted against you.','In this event you\'ll use your creativity to design and build the dreaded war machine of the ancient world, the catapult, aiming to destroy any other pitted against you. So only if you have what it takes to take part in this Battle Royale, then get ready to lay SEIGE to your opponents.','images/siege.png','Ghalia Saad Siddiqui','Ali Samiq','NONE','0336 1043657','0323 5861214','NONE','images/eh1_siege.jpg','images/eh2_siege.jpg','NONE','images/cover_siege.png'),
    EventDoc('Gear Up','Does the practical application of Physics intrigue you? Challenge your innovative guts and discover the hidden scientist inside you.','Does the practical application of Physics intrigue you? If yes, then here\'s your chance. Challenge your innovative guts and your mental skills by becoming a part of our Gear Up family, which might help you discover the hidden scientist inside you.','images/gearup.png','Muhammad Hameed','Amna Ghafoor','NONE','3349962167','3035133594','NONE','images/eh1_gearup.jpg','images/eh2_gearup.jpg','NONE','images/cover_gearup.png'),
    EventDoc('Tour De Mind','Do you think you have the skills to be a detective? Does deciphering code get your blood flowing? Three days of deciphers and fun!','Do you think you have the skills to be a detective? Does deciphering code get your blood flowing? Then this is the event for you. Three days of deciphers and fun!','images/tdm.png','Haram Siddique','Mahad Abdullah Shahid','NONE','0322 4520536','0307 4217321','NONE','images/eh1_tdm.jpg','images/eh2_tdm.jpg','NONE','images/cover_tdm.png'),
    EventDoc('Math Gauge','Be the smartest and stupidest with us and join Math Gauge, the most thrilling event of PSIFI, full of fun and real challenges!','Be the smartest and stupidest with us and join Math Gauge, the most thrilling event of PSIFI, full of fun and real challenges and reveal... ','images/mathgauge.png','Samreen Khurram','Maira Hassan','NONE','0333 6720870','0333 8054922','NONE','images/eh1_mathgauge.jpg','images/eh2_mathgauge.jpg','NONE','images/cover_mathgauge.png'),
  ];

  @override
  void initState(){
    super.initState();
  }

  Widget eventCardBox(EventDoc doc){
    return Container(
      //padding: new EdgeInsets.only(left:12.0, right: 10.0, bottom: 3.0, top: 3.0),      
      child: InkWell(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> EventPage(doc)));
        },
        child: EventCard(
          title: new Padding(
            padding: EdgeInsets.all(2.0),
            child: new Text(' ' + doc.title,style: new TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500)),
          ),
          shortDesc: new Padding(
            padding: EdgeInsets.only(left: 10.0, right: 4.0),
            child: Text(doc.shortDesc, style:new TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic)),
          ),
          logo: AssetImage(doc.logoImage),
          //OR logo: NetworkImage("images/techwars.png")
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:10.0),
        child: ListView.builder(
          itemCount: docList.length,
          itemBuilder:(context,index) =>
            GestureDetector(
              child: eventCardBox(docList[index])
            ),
        )
      )
    );
  }
}

class EventCard extends StatelessWidget {
  EventCard({this.title, this.shortDesc, this.logo});

  final ImageProvider logo;
  final Widget shortDesc;
  final Widget title;

  @override
  Widget build(BuildContext context){
    return new Card(
          elevation: 2.5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                Image(
                    image: this.logo,
                    fit: BoxFit.cover,
                    //height: 240.0,
                ),
                this.title,
                this.shortDesc,
                SizedBox(height: 15.0),
              ],
          ),
    );
  }
}
