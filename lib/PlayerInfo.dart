import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TrophyListArr extends StatefulWidget {

  @override
  _TrophyListArrState createState() => _TrophyListArrState();
}

class _TrophyListArrState extends State<TrophyListArr> {



  @override
  Widget build(BuildContext context) {
    var futureBuilder=new FutureBuilder(
        future: makecall.firebaseCalls(databaseReference), // async work
    builder: (BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
    case ConnectionState.none: return new Text('Press button to start');
    case ConnectionState.waiting: return new Text('Loading....');
    default:
    if (snapshot.hasError)
    return new Text('Error: ${snapshot.error}');
    else
    return ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index){
    return Card(
    elevation: 0.0,
    child: Padding(
    padding: const EdgeInsets.all(0.0),
    child:  SizedBox(
    height: MediaQuery.of(context).size.height*0.15,
    width: MediaQuery.of(context).size.width,
    child:  Card(
    elevation: 0,
    child:,)
    )
    )
    );
    );
    }
    );

    return Expanded(
        child:Container(
            child: ListView.builder(),
        )
    );
  }
}

class MakeCall {
  List<PlayerTrophyInfo> listItems = [];

  Future<List<PlayerTrophyInfo>> firebaseCalls(
      DatabaseReference databaseReference) async {
    PlayerTrophiesInfoArr recipeList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic, dynamic> jsonResponse = dataSnapshot.value;
    recipeList = new PlayerTrophiesInfoArr.fromJSON(jsonResponse);
    listItems.addAll(recipeList.playersList);

    return listItems;
  }
}
  class PlayerTrophyInfo{
  String trophyid;
  String trophyname;


    PlayerTrophyInfo({
      this.trophyname,
      this.trophyid,
    });

  factory PlayerTrophyInfo.fromJson(Map<dynamic,dynamic> parsedJson) {
    return PlayerTrophyInfo(trophyid:parsedJson['trohpyid'],trophyname: parsedJson['trophyname']);
  }
}

class PlayerTrophiesInfoArr {

  final dbReff = FirebaseDatabase.instance.reference();
  List<PlayerTrophyInfo> playersList;

  PlayerTrophiesInfoArr({
    this.playersList
  });

  factory PlayerTrophiesInfoArr.fromJSON(Map<dynamic,dynamic>json){
    return PlayerTrophiesInfoArr(
        playersList: parserecipes(json)
    );
  }
  static List<PlayerTrophyInfo> parserecipes(recipeJSON){
    var rList = recipeJSON['trophies'] as List;
    List<PlayerTrophyInfo> recipeList=rList.map((data) => PlayerTrophyInfo.fromJson(data)).toList();  //Add this
    return recipeList;
  }
}