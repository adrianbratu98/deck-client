
//import 'dart:io';

import 'package:deck/services/base.service.dart';
import 'package:signalr_client/signalr_client.dart';
//import 'package:path_provider/path_provider.dart';

class SignalrService {
  static HubConnection _hubConnection;

  static Future<String> get _serverUrl async {
    String serverUrl = "http://30c40889.eu.ngrok.io/deck";
    // final directory = await getApplicationDocumentsDirectory();
    // final filePath = '${directory.path}/deck.txt';
    // if (File(filePath).existsSync())
    //   serverUrl = File(filePath).readAsStringSync();
    // else File(filePath).writeAsStringSync(serverUrl);
    return serverUrl;
  }

  static const int ATTEMPT_CONNECTION_TIMEOUT_IN_MS = 2 * 60 * 1000;

  static Future startConnection() async {
    _hubConnection = HubConnectionBuilder().withUrl(await _serverUrl).build();
    _hubConnection.onclose((_) {
      tryConnect(attempts: 3, expiresOn: getTimeStampAfter(minutes: 2))
        .then((_) => BaseService.onReconnected())
        .catchError((_) => BaseService.onAborted());
      BaseService.onDisconnected();
    });
    return await tryConnect(expiresOn: getTimeStampAfter(minutes: 2))
      .then((_) => BaseService.onConnected())
      .catchError((_) => BaseService.onAborted());
  }

  static int getTimeStampAfter({int minutes = 0, int seconds = 0}) => DateTime.now()
    .add(Duration(minutes: minutes, seconds: seconds))
    .millisecondsSinceEpoch;

  static Future tryConnect({int attempts = 0, int expiresOn}) async {
    return _hubConnection.start()
      .catchError((_) async {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (attempts > 0 && now < expiresOn) {
          final Duration timeout = Duration(milliseconds: ((expiresOn - now) / attempts) as int);
          return await Future.delayed(timeout, () => tryConnect(attempts: attempts, expiresOn: expiresOn));
        }
        else if (now < expiresOn)
          return await tryConnect(expiresOn: expiresOn);
        throw Error();
      });
  }

  static Future invoke(String methodName, { List<Object> args }) async =>
    _hubConnection.invoke(methodName, args: args);

  static setHandler(String methodName, void Function(dynamic) callback) =>
    _hubConnection.on(methodName, (returned) => callback(returned[0]));
}
