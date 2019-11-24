import 'dart:async';

import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  Loading(this.loadingText);
  _LoadingState createState() => _LoadingState();
  final String loadingText;
}

class _LoadingState extends State<Loading>{

  int dots = 0;
  Timer timer;
  
  @override
  void initState() {
    changeDots();
    super.initState();
  }

  @protected
  @mustCallSuper
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  changeDots(){
    timer = Timer(Duration(milliseconds:  500), () {
      setState(() {
        dots = (dots + 1) % 4;
        changeDots();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(widget.loadingText + "...".substring(0, dots))
      )
    );
  }
}
