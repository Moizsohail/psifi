import 'package:flutter/material.dart';
import 'eventpage.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

class EventDoc {   
  final String title, shortDesc, longDesc, logoImage, eh1, eh2, eh1Contact, eh2Contact, eh1Image, eh2Image, coverImage;
  const EventDoc(this.title, this.shortDesc, this.longDesc, this.logoImage, this.eh1, this.eh2, this.eh1Contact, this.eh2Contact, this.eh1Image, this.eh2Image, this.coverImage);
}

// Another option instead of file loading usage
// String eventDataRaw = """
// Title,ShortDesc,LongDesc,LogoImage,EH1,EH2,EH1Contact,EH2Contact,EH1Image,EH2Image,CoverImage
// Robo Wars,Learn to equip% equip to fight% fight to defend. Defend the flag with your Battlebot in our Robowars.,Learn to equip% equip to fight% fight to defend. Defend the flag with your Battlebot in our Robowars.,images/robowars.png,Rana Sher Ali,Omair Faqah ur Rehman,0307 3749589,0302 2113965,images/eh1_robowars.jpg,images/eh2_robowars.jpg,images/cover_robowars.jpg
// Siege,Build the dreaded war machine of the ancient world% the catapult% aiming to destroy any other pitted against you.,In this event you'll use your creativity to design and build the dreaded war machine of the ancient world% the catapult% aiming to destroy any other pitted against you. So only if you have what it takes to take part in this Battle Royale% then get ready to lay SEIGE to your opponents.,images/siege.png,Ghalia Saad Siddiqui,Ali Samiq,0336 1043657,0323 5861214,images/eh1_siege.jpg,images/eh2_siege.jpg,images/cover_siege.jpg
// Tech Wars,Intense competitions involving ethical hacking% aerospace and reverse engineering where you put your problem solving and debugging skills to the test!,Grab your fellow geeks and prepare for some intense competitions involving ethical hacking% aerospace and reverse engineering where you put your problem solving% debugging and other technical skills to the test! Tech Wars - be ready.,images/techwars.png,Zoraiz Qureshi,Ahmad Humayun,0331 4385434,0330 4232323,images/eh1_techwars.jpg,images/eh2_techwars.jpg,images/cover_techwars.jpg
// Galactica,A glimpse of the future% a race against time! Give the Jetsons a run for their money by reimagining your own utopian space settlement!,A glimpse of the future% a race against time! Give the Jetsons a run for their money by reimagining your own utopian space settlement!,images/galactica.png,Maham Rasheed,NONE,+92 323 1495519,NONE,images/eh1_galactica.jpg,NONE,images/cover_galactica.jpg
// Gear Up,Does the practical application of Physics intrigue you? Challenge your innovative guts and discover the hidden scientist inside you.,Does the practical application of Physics intrigue you? If yes% then here's your chance. Challenge your innovative guts and your mental skills by becoming a part of our Gear Up family% which might help you discover the hidden scientist inside you.,images/gearup.png,Muhammad Hameed,Amna Ghafoor,3349962167,3035133594,images/eh1_gearup.jpg,images/eh2_gearup.jpg,images/cover_gearup.jpg
// Tour De Mind,Do you think you have the skills to be a detective? Does deciphering code get your blood flowing? Three days of deciphers% RGMs and fun!,Do you think you have the skills to be a detective? Does deciphering code get your blood flowing? Then this is the event for you. Three days of deciphers% RGMs and fun!,images/tdm.png,Haram Siddique,Mahad Abdullah Shahid,0322 4520536,0307 4217321,images/eh1_tdm.jpg,images/eh2_tdm.jpg,images/cover_tdm.jpg
// Math Gauge,Be the smartest and stupidest with us and join Math Gauge% the most thrilling event of PSIFI% full of fun and real challenges!,Be the smartest and stupidest with us and join Math Gauge% the most thrilling event of PSIFI% full of fun and real challenges and reveal... ,images/mathgauge.png,Samreen Khurram,Maira Hassan,0333 6720870,0333 8054922,images/eh1_mathgauge.jpg,images/eh2_mathgauge.jpg,images/cover_mathgauge.jpg
// Diagnosis Dilemma,Teams will be tested on the basis of their medical knowledge and their perseverance under pressure and only those that are able to keep their cool and perform will be able to make it.,Get ready for a unique challenge in this year's PsFi: Diagnosis Dilemma; where teams will be tested on the basis of their medical knowledge and their perseverance under pressure and only those that are able to keep their cool and perform will be able to make it.,images/dd.png,Hamza Humayun,Areeba Suhail,0332 4433986,0320 4334915,images/eh1_dd.jpg,images/eh2_dd.jpg,images/cover_dd.jpg
// Science Crime Busters,Use your detective skills and forensic knowledge to eliminate the impossible and unravel the truth.,Use your detective skills and forensic knowledge to eliminate the impossible and unravel the truth.,images/scb.png,Daniyal Tiwana,Zoya Shamsi,0324 4445553,0344 4443484,images/eh1_scb.jpg,images/eh2_scb.jpg,images/cover_scb.jpg
// """;

Future<String> loadAsset(String path) async {
  return await rootBundle.loadString(path);
}

class EventsPortal extends StatefulWidget{
  EventsPortal(); //empty constructor body

  @override
  State<StatefulWidget> createState() => EventsPortalState();
}

class EventsPortalState extends State<EventsPortal>{
  List<EventDoc> docList = new List();
              
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


  //Must load from CSV instead of firestore now
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:10.0),
        child: FutureBuilder<String>(
          future: loadAsset("assets/eventData.csv"), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Text('');
              case ConnectionState.done:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                
                if (docList.length == 0){
                  for (String line in  snapshot.data.split('\n')) {
                    List<String> elements = line.split(',');
                    if (elements.length == 11){
                      docList.add(new EventDoc(elements[0], elements[1].replaceAll('%', ','), elements[2].replaceAll('%', ','), elements[3], elements[4], elements[5], elements[6], elements[7], elements[8], elements[9], elements[10].trim()));
                    }   
                  }
                  docList.removeAt(0); //remove first line          
                }

                return ListView.builder(
                  itemCount: docList.length,
                  itemBuilder:(context,index) =>
                    GestureDetector(
                      child: eventCardBox(docList[index])
                    ),
                );
            }
            return null; // unreachable
          },
        ),
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
