import 'package:deck/models/lobby.dart';
import 'package:deck/models/player.dart';
import 'package:deck/plugins/public-notifier.dart';
import 'package:deck/services/signalr.service.dart';
import 'package:flutter/material.dart';

class BaseService {

  static ValueNotifier<bool> isConnected = new ValueNotifier(false);

  static Player player = new Player();

  static PublicNotifier<Map<String, Lobby>> lobbies = new PublicNotifier<Map<String, Lobby>>(new Map<String, Lobby>());

  static ValueNotifier<Lobby> currentLobby = new ValueNotifier(null);

  static void initializeApp() {
    SignalrService.startConnection().then((_) {
      SignalrService.setHandler("ALobbyWasCreated", BaseService.aLobbyWasCreated);
      SignalrService.setHandler("ALobbyWasClosed", BaseService.aLobbyWasClosed);
      SignalrService.setHandler("APlayerJoinedALobby", BaseService.aPlayerJoinedALobby);
      SignalrService.setHandler("ALobbyHasANewLeader", BaseService.aLobbyHasANewLeader);
      SignalrService.setHandler("APlayerLeftALobby", BaseService.aPlayerLeftALobby);
      SignalrService.setHandler("ResetLobbies", BaseService.resetLobbies);
    });
  }

  static onConnected() =>
    isConnected.value = true;

  static onDisconnected() =>
    isConnected.value = false;

  static onReconnected() => player.id != null
    ? SignalrService.invoke("TryReconnect", args: [player.id])
        .then((_) =>
          isConnected.value = true)
    : onAborted();

  static onAborted() =>
    isConnected.value = false;

  static getUniqueId() async => player.id = await SignalrService.invoke("GetUniqueId");

  static Future getLobbies() async => SignalrService.invoke("GetLobbies")
    .then(BaseService.resetLobbies);
  
  static joinLobby(Lobby lobby) async => await SignalrService.invoke("JoinLobby", args: [lobby.id, player])
    .then((result) =>
     currentLobby.value = lobby);
  
  static aLobbyWasCreated(dynamic lobbyJson) {
    Lobby lobby = Lobby.fromJson(lobbyJson);
    lobbies.value[lobby.id] = lobby;
    lobbies.notifyListeners();
  }
  
  static aLobbyWasClosed(dynamic lobbyId) {
    lobbies.value.remove(lobbyId as String);
    lobbies.notifyListeners();
  }

  static aPlayerJoinedALobby(dynamic actionJson) {
    Player player = Player.fromJson(actionJson['player']);
    Lobby lobby = lobbies.value[actionJson['lobbyId'] as String];
    lobby.players[actionJson['playerId']] = player;
    lobbies.notifyListeners();
  }

  static aLobbyHasANewLeader(dynamic actionJson) {
    Lobby lobby = lobbies.value[actionJson['lobbyId'] as String];
    lobby.players.remove(lobby.leaderId);
    lobby.leaderId = actionJson['leaderId'] as String;
    lobbies.notifyListeners();
  }

  static aPlayerLeftALobby(dynamic actionJson) {
    String playerId = actionJson['playerId'] as String;
    Lobby lobby = lobbies.value[actionJson['lobbyId'] as String];
    lobby.players.remove(playerId);
    lobbies.notifyListeners();
  }

  static resetLobbies(dynamic lobbiesJson) {
    lobbies.value = lobbiesJson.map<String, Lobby>(
      (key, value) => MapEntry(key.toString(), Lobby.fromJson(value))
    );
  }
}
 