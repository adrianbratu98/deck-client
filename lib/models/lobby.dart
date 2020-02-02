import 'package:deck/models/player.dart';
import 'package:deck/widgets/identitiy.dart';
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
  Map<String, Player> players;
  
  Player get leader => players[leaderId];

  factory Lobby.fromJson(Map<String, dynamic> json) => _$LobbyFromJson(json);

  Map<String, dynamic> toJson() => _$LobbyToJson(this);

  Widget toLobbyListItem(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Identity(
          name, 
          "images/${icon.toString().substring(icon.toString().lastIndexOf('.') + 1)}.png",
          45
      ),
    );
  }
 }
 
enum LobbyIcon {
  Cats,
  Dogs,
  TheFishBank
}