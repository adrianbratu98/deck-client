import 'package:deck/models/player.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'lobby.g.dart';

@JsonSerializable()
class Lobby { 

  Lobby();

  String id;
  String name;
  @JsonKey(name: "icon")
  int iconCode;
  LobbyIcon get icon => LobbyIcon.values[iconCode];
  String leaderId;
  Map<String, Player> participants;
  
  Player get leader => participants[leaderId];

  factory Lobby.fromJson(Map<String, dynamic> json) => _$LobbyFromJson(json);

  Map<String, dynamic> toJson() => _$LobbyToJson(this);

  Widget toLobbyListItem(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black12
            ),
            child: Image(
              image: AssetImage("assets/images/${icon.toString().substring(icon.toString().lastIndexOf('.') + 1)}.png"),
              width: 45,
              height: 45,
            ),
          ),
          Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ]
      ),
    );
  }
 }
 
enum LobbyIcon {
  Cats,
  Dogs,
  TheFishBank
}