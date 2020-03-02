import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PlayerInfo extends StatefulWidget {
  PlayerInfo();

  @override
  _PlayerInfoState createState() => _PlayerInfoState();
}

class _PlayerInfoState extends State<PlayerInfo> {
  final dbReff = FirebaseDatabase.instance.reference().child("Person");

  final dbCurrentPlayer = FirebaseDatabase.instance.reference().child("CurrentPlayer");
  String trophies_str =null;
  String trops;
  void initState(){
    super.initState();
    trophies();
    print(trophies_str);
  }
  trophies() async {
    dbCurrentPlayer.once().then((DataSnapshot ds){
      trophies_str = ds.value.toString();
    });

    setState(() {

    });
  }
  bodyWidget(BuildContext context)=>Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height /4,
        width: MediaQuery.of(context).size.width -20,
        left: 10.0,
        top: MediaQuery.of(context).size.height * 0.05,
        child: Card(
          elevation: 40.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(

            children: <Widget>[
              Positioned(
                top: 40,
                  left: 40,
                  child: Image.asset('assets/assets_images/man1.png',height: 100.0,width: 100.0,)),

              Positioned(
                  top: 70,
                  left: 200,
                  child: Text("Mihir Mehta",style: TextStyle(fontSize: 30,fontWeight:  FontWeight.bold),)),
//              Row(
//                children: <Widget>[
//                  RaisedButton(
//                    child: Text("RAISED"),
//                      onPressed: (){
//                          insert();
//                      }
//                  ),
//                  RaisedButton(
//                    child: Text("READ"),
//                      onPressed:(){
//                        read();
//                      }
//                  )
//
//                ],
//              )
            ],
          ),
        ),
      ),
      Container(
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 300.0),
        child: ListView(

          children: <Widget>[

            Container(
              width: MediaQuery.of(context).size.width ,
              child: Center(
                child: trophies_str == null ?
                    CircularProgressIndicator()
                : Text(trophies_str),
              ),
            ),

          ],
          scrollDirection :Axis.horizontal,
        ),
      ),
      Positioned(
        bottom: 60,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircularPercentIndicator(
                radius: 200.0,
                lineWidth: 15.0,
                percent: 0.85,
                center: new Text("Total Pokemon",style:TextStyle(color: Colors.white,fontSize: 25),),
                progressColor: Colors.deepPurple,
              ),

              CircularPercentIndicator(
                radius: 200.0,
                lineWidth: 15.0,
                percent: 0.4,
                center: new Text("Shiny Pokemon",style:TextStyle(color: Colors.white,fontSize: 25),),
                progressColor: Colors.teal,
              ),

            ],
          ),
        ),


    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(

        backgroundColor: Colors.cyan,
        title: Text('About Me'),
      ),

      body: bodyWidget(context),
    );
  }

  void insert(){
    /*dbReff.child("P111").set({
      'id': 'P111',
      'Data': 'This is a data',
    });*/
  }

  void read(){
    /*dbReff.once().then((DataSnapshot ds){
     print(ds.value);
    });
    print(dbReff);*/
  }
}
