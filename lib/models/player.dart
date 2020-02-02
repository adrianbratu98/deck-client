import 'package:deck/widgets/identitiy.dart';
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
  set icon(PlayerIcon icon2) => iconCode = icon2.index;

  static PlayerIcon asIcon(int iconCode) => PlayerIcon.values[iconCode];

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  Widget toLobbyPlayer(){
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Identity(
        name, 
        "images/${icon.toString().substring(icon.toString().lastIndexOf('.') + 1)}.png",
        30
      ),
    );
  }
}

enum PlayerIcon {
  Cat,
  Dog,
  Fish
}

 
