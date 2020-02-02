import 'package:deck/screens/intro.dart';
import 'package:deck/services/base.service.dart';
import 'package:flutter/material.dart';

void main() => runApp(DeckApp());

class DeckApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    BaseService.initializeApp();
    return MaterialApp(
      title: 'Deck',
      theme: ThemeData(
         primarySwatch: Colors.blue,
      ),
      home: IntroScreen(),
    );
  }
}



