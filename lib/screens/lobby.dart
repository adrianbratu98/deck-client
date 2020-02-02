import 'package:deck/models/lobby.dart';
import 'package:deck/services/base.service.dart';
import 'package:deck/widgets/identitiy.dart';
import 'package:deck/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LobbyScreen extends StatefulWidget {
  LobbyScreen(Lobby lobby, {Key key}) : super(key: key);

  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {

  bool lobbyJoined = false;

  @override
  void initState() { 
    super.initState();
    BaseService.currentLobby.addListener(() {
      setState(() { lobbyJoined = true; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: !lobbyJoined ?
          Loading("gioning lobby, mâncați-aș!") :
          Column(
            children: BaseService.currentLobby.value.players.values
              .map((player) => Identity(player.name, player.icon.toString(), 45))
              .toList(),
          ),
      ),
    );
  }
}
