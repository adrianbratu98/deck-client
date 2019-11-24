import 'package:deck/components/loading.dart';
import 'package:deck/services/base.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lobbies.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController controller = TextEditingController();
  @override
  void initState() { 
    super.initState();
    BaseService.isConnected.addListener(() {
      setState(() {});
    });
  }

  login(BuildContext context) async{
    if(controller.text.isNotEmpty){
      await BaseService.getUniqueId();
      Navigator.push(context,MaterialPageRoute(builder: (context) => Lobbies()));
    }
    else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Username can not be empty')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: !BaseService.isConnected.value ?
            Loading("Connecting to server") : 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Username:"),
                TextFormField(
                  controller: controller,
                ),
                Builder(
                  builder: (context) => 
                    FlatButton(
                      onPressed: () => login(context),
                      child: Text("Log in"),
                  ),
                )
              ],
            ),
        ),
      )
    );
  }
}
 