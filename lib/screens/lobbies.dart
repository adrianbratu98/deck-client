import 'package:deck/components/loading.dart';
import 'package:deck/services/base.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lobbies extends StatefulWidget {
  Lobbies({Key key}) : super(key: key);

  _LobbiesState createState() => _LobbiesState();
}

class _LobbiesState extends State<Lobbies> {

  bool lobbiesRecived = false;

  @override
  void initState() { 
    super.initState();
    BaseService.getLobbies()
    .then((_) {
        setState(() {
          lobbiesRecived = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         body: Center(
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: !lobbiesRecived ?
              Loading("Getting lobbies") :
              ListView(
                children: BaseService.lobbies.values.map((lobby) =>
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Lobbies())),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          lobby.toLobbyListItem(),
                          ...lobby.participants.values.map((participant) => participant.toLobbyPlayer())
                        ]
                      )
                    ),
                  )
                ).toList()
              ),
           )
         )
       )
    );
  }
}
