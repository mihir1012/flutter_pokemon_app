import 'package:flutter/material.dart';
import 'package:flutterpokemonapp/pokes.dart';

class PokeDetail extends StatelessWidget {
  
  final Pokemon pokemon;
  
  PokeDetail({this.pokemon});

    bodyWidget(BuildContext context) => Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height /1.5,
        width: MediaQuery.of(context).size.width -20,
        left: 10.0,
        top: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          elevation: 40.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              SizedBox(
                height: 100.0,
              ),
              Text(pokemon.name ,style: TextStyle(fontSize: 25.0, fontWeight:FontWeight.bold),),
              Text("Height: ${pokemon.height}"),
              Text("Weight:${pokemon.weight}"),
              Text("Types",style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.type.map(
                    (t) => FilterChip(backgroundColor: Colors.amber,label: Text(t), onSelected: (b){})
                ).toList(),
              ),
              Text("Weakness",style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.weaknesses.map(
                        (t) =>  FilterChip(backgroundColor: Colors.red,label: Text(t,style: TextStyle(color: Colors.white),), onSelected: (b){})
                ).toList(),
              ),
              Text("Next Evolution",style: TextStyle(fontWeight: FontWeight.bold),),
              pokemon.nextEvolution!=null ? Container  (
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.nextEvolution.map(
                          (n) => FilterChip(backgroundColor: Colors.lightGreen,label: Text(n.name), onSelected: (b){}),
                  ).toList(),
                ),
              ):Text("No Next Evolution"),
              Text("Prev Evolution",style: TextStyle(fontWeight: FontWeight.bold),),

              pokemon.prevEvolution!=null ? Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.prevEvolution.map(
                          (n) => FilterChip(backgroundColor: Colors.deepPurple,label: Text(n.name,style: TextStyle(color: Colors.white),), onSelected: (b){})
                  ).toList(),
                ),
              ):Text("Basic Form"),
            ],
          ),
        ),
      ),

      Align(
        alignment: Alignment.topCenter,
        child: Hero(tag: pokemon.img, child: Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(pokemon.img)
            )
          ),
        )),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text(pokemon.name),
      ),

      body: bodyWidget(context),
    );
  }
}
