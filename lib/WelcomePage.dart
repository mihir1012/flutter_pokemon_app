import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterpokemonapp/HomePage.dart';


class WelcomePage extends StatelessWidget {
  WelcomePage();
  DatabaseReference dbreff = FirebaseDatabase.instance.reference().child("Person");
  DatabaseReference dbplayerCount = FirebaseDatabase.instance.reference().child("CountPlayer");
  DatabaseReference dbCurrent = FirebaseDatabase.instance.reference().child("CurrentPlayer");
  final textControl = TextEditingController();
  void dispose(){
    textControl.dispose();
  }

  static final _registeringForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text("WelCome"),
        backgroundColor: Colors.cyan,
      ),
      body: Form(
        key: _registeringForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height /10,
              width: MediaQuery.of(context).size.width -20,
              child: Card(
                elevation: 40.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(child: Text("Welcome To the PokeDesk!!",style: TextStyle(fontSize: 25.0),))
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height /10,
                width: MediaQuery.of(context).size.width -20,
                child: Card(
                    elevation: 40.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(child: Text("Please Register before Continuing",style: TextStyle(fontSize: 25.0),)
                    )
                )
            ),
            TextFormField(
              controller: textControl,
              validator: (value){
                if(value.isEmpty){
                  return 'Please enter text';
                }
                return null;
              },
              decoration: InputDecoration(
                fillColor: Colors.deepOrange,
                focusColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Enter Your Name',
                labelStyle: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold),
              ),

              keyboardAppearance: Brightness.dark,
              style: TextStyle(fontSize: 30.0, color: Colors.white),

            ),
            RaisedButton(
                onPressed: (){
                  if(/*_registeringForm.currentState.validate()*/true){
                      SavePlayer(textControl.text,context);
                  }
                },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }

  void SavePlayer(String val,BuildContext context){
    dbCurrent.once().then((DataSnapshot ds){
      print(ds.value);
      print(val);
    });
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context)=> new HomePage())
    );
  }
}
