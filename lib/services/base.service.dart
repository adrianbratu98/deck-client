import 'package:deck/models/lobby.dart';
import 'package:deck/models/player.dart';
import 'package:deck/services/signalr.service.dart';
import 'package:flutter/material.dart';

class BaseService {

  static ValueNotifier<bool> isConnected = new ValueNotifier(false);

  static Player player = new Player();

  static Map<String, Lobby> lobbies;

  static Lobby currentLobby;

  static void initializeApp() {
    SignalrService.startConnection();
  }

  static onConnected() => isConnected.value = true;

  static getUniqueId() async => player.id = await SignalrService.invoke("GetUniqueId");

  static Future getLobbies() async => 
    SignalrService.invoke("GetLobbies")
      .then((rawData) {
        lobbies = (rawData).map<String, Lobby>(
          (key, value) => MapEntry(key.toString(), Lobby.fromJson(value))
        );
      });
  
  static joinLobby(Lobby lobby) async => await SignalrService.invoke("JoinLobby")
    .then((result) => currentLobby = lobby);
}
