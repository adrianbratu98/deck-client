import 'dart:async';
import 'package:deck/screens/home.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Intro screen")
      ),
    );
  }
}
