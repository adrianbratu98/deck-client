import 'dart:async';
import 'package:deck/screens/home.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("IntroScreen screen")
      ),
    );
  }
}
