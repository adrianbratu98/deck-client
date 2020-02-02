// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lobby _$LobbyFromJson(Map<String, dynamic> json) {
  return Lobby()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..iconCode = json['icon'] as int
    ..leaderId = json['leaderId'] as String
    ..players = (json['participants'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Player.fromJson(e as Map<String, dynamic>)),
    );
}

Map<String, dynamic> _$LobbyToJson(Lobby instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.iconCode,
      'leaderId': instance.leaderId,
      'participants': instance.players
    };
