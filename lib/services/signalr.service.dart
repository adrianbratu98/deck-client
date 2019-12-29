
import 'package:deck/services/base.service.dart';
import 'package:signalr_client/signalr_client.dart';

class SignalrService {
  static String _serverUrl = "http://675061de.ngrok.io/deck";
  static HubConnection _hubConnection;

  static startConnection() async {
    _hubConnection = HubConnectionBuilder()
      .withUrl(_serverUrl)
      .build();
    _hubConnection.start()
      .then((_) =>
       BaseService.onConnected());
  } 

  static Future invoke(String methodName, {List<Object> args}) async =>
    _hubConnection.invoke(methodName, args: args);

  static setHandler(String methodName, void Function(dynamic) callback) =>
    _hubConnection.on(methodName, (returned) => callback(returned[0]));
}
