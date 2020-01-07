
import 'dart:io';

import 'package:deck/services/base.service.dart';
import 'package:signalr_client/signalr_client.dart';
import 'package:path_provider/path_provider.dart';

class SignalrService {
  static HubConnection _hubConnection;

  static Future<String> get _serverUrl async {
    String serverUrl = "http://8d51454d.eu.ngrok.io/deck";
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/deck.txt';
    if (File(filePath).existsSync())
      serverUrl = File(filePath).readAsStringSync();
    else File(filePath).writeAsStringSync(serverUrl);
    return serverUrl;
  }

  static Future startConnection() async {
    _hubConnection = HubConnectionBuilder().withUrl(await _serverUrl).build();
    return await _hubConnection.start().then(BaseService.onConnected);
  }

  static Future invoke(String methodName, {List<Object> args}) async =>
    _hubConnection.invoke(methodName, args: args);

  static setHandler(String methodName, void Function(dynamic) callback) =>
    _hubConnection.on(methodName, (returned) => callback(returned[0]));
}
