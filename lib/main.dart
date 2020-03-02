import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutterpokemonapp/HomePage.dart';
import 'package:flutterpokemonapp/WelcomePage.dart';

void main() => runApp(MaterialApp(
    title: "Poke APP",
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));

class SplashScreen extends StatefulWidget {
  SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = (prefs.getBool('firstTime') ?? true );
    if(firstTime ){
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context)=> new WelcomePage())
      );
      prefs.setBool('firstTime', false);
    }
    else{
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context)=> new HomePage())
      );
    }
  }
  void initState(){
    super.initState();
    new Timer(new Duration(seconds: 0), (){
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Center(
        child: Text('Loading...',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}
