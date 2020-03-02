import 'package:flutter/material.dart';
import 'package:flutterpokemonapp/Player.dart';
import 'package:flutterpokemonapp/pokemonDetail.dart';
import 'package:flutterpokemonapp/pokes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    print(pokeHub.toJson());
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Poke App"),
        backgroundColor: Colors.cyan,
      ),

      body: pokeHub== null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GridView.count ( crossAxisCount: 2,
        children: pokeHub.pokemon.map((poke)=>Padding(padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>PokeDetail(pokemon: poke,)
              ));
            },
            child: Hero(
              tag: poke.img,
              child: Card(
                elevation: 3.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(poke.img),
                        ),
                      ),
                    ),
                    Text(poke.name,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ),
        )).toList(),


      ),


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(

              child: Stack(
                children: <Widget>[

                  Positioned(
                    child: Container(
                        child: Image.asset("assets/assets_images/pokemon.png",height: 100.0,width: 100.0,)
                    ),
                  ),
                  Positioned(right:5.0,bottom: 5.0,child: Text("PokeDesk",style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold),))
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
            ),
            ListTile(
              title: Text('PlayerInfo',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>PlayerInfo()));

              },
            ),

          ],
        ),
      ),



      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>HomePage()
        ));
      },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

