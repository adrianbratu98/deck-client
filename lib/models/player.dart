import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'player.g.dart';

@JsonSerializable()
class Player {

  Player();
  
  String id;
  String name;
  @JsonKey(name: "icon")
  int iconCode;
  PlayerIcon get icon => PlayerIcon.values[iconCode];

  static PlayerIcon asIcon(int iconCode) => PlayerIcon.values[iconCode];

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  Widget toLobbyPlayer(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 8, 8, 8),
      child: Row(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black12
            ),
            child: Image(
              image: AssetImage("assets/images/${icon.toString().substring(icon.toString().lastIndexOf('.') + 1)}.png"),
              width: 30,
              height: 30,
            ),
          ),
          Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
            ),
          )
        ]
      ),
    );
  }
}

enum PlayerIcon {
  Cat,
  Dog,
  Fish
}

 
