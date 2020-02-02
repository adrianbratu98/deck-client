import 'package:deck/models/lobby.dart';
import 'package:deck/screens/lobby.dart';
import 'package:deck/services/base.service.dart';
import 'package:deck/widgets/identitiy.dart';
import 'package:deck/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LobbiesScreen extends StatefulWidget {
  LobbiesScreen({Key key}) : super(key: key);

  _LobbiesState createState() => _LobbiesState();
}

class _LobbiesState extends State<LobbiesScreen> {

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
    BaseService.lobbies.addListener(() {
      setState(() {});
    });
  }

  joinLobby(Lobby lobby) {
    BaseService.joinLobby(lobby);
    Navigator.push(context, MaterialPageRoute(builder: (context) => LobbyScreen(lobby)));
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
                children: BaseService.lobbies.value.values.map((lobby) =>
                  GestureDetector(
                    onTap: () => joinLobby(lobby),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Identity(lobby.name, lobby.icon.toString(), 45),
                          ...lobby.players.values.map((player) => Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Identity(player.name, player.icon.toString(), 30),
                          ))
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
