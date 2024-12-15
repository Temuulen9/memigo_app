import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:memigo/api/lib/log.dart';

class ConnectionStatusSingleton {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatusSingleton _singleton =
      ConnectionStatusSingleton._internal();

  ConnectionStatusSingleton._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatusSingleton getInstance() => _singleton;

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController =
      StreamController<dynamic>.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    initConnectivity();
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    //checkConnection();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    var result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //todo ConnectivityBloc().add(ConnectivityChecking());
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log.f(e.toString(), error: e);
    }

    // // If the widget was removed from the tree while the asynchronous platform
    // // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // if (!mounted) {
    //   return Future.value(null);
    // }

    return _connectionChange(result);
  }

  // network holbogdson ch gesen zaaval manai server asaalttai esehiig shalgah shaardlaggui gej uzev
  // void refresh() {
  //   checkConnection();
  // }

  Stream get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    String string;
    switch (result) {
      case ConnectivityResult.none:
        string = "Offline";
        hasConnection = false;
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        hasConnection = true;
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
        hasConnection = true;
        break;
    }

    log.d('connection status: $string');
    // log.d('$runtimeType _connectionChange() result:$result');

    //todo ConnectivityBloc().add(hasConnection?ConnectivityConnected():ConnectivityNotConnected());
    connectionChangeController.add(hasConnection);
    //checkConnection();
  }

//The test to actually see if there is a connection
// Future<bool> checkConnection() async {
//   var previousConnection = hasConnection;
//
//   try {
//
//     log.d('kIsWeb: $kIsWeb');
//
//     if(kIsWeb){
//       hasConnection = true;
//       return hasConnection;
//     }
//
//     final urlSource = apiHelper?.currentApiUrl?.baseUrl ?? 'https://www.google.com/';
//
//     final uri = Uri.parse(urlSource);
//     log.d('urlSource: $urlSource, uri.host: ${uri.host}');
//
//     final result = await InternetAddress.lookup(uri.host);
//     log.d('$runtimeType result: $result');
//
//     int i = 0;
//     result?.forEach((element) {
//       log.d('$runtimeType result[$i] => $element - ${element.rawAddress} - ${element.address}');
//       i++;
//     });
//
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       log.d('$runtimeType -> result[0]: ${result[0]}');
//       hasConnection = true;
//     } else {
//       log.d('$runtimeType set hasConnection=>false');
//       hasConnection = false;
//     }
//   } on SocketException catch (_) {
//     log.wtf(runtimeType, _);
//     hasConnection = false;
//   }
//
//   //The connection status changed send out an update to all listeners
//   log.d('$runtimeType checkConnection() previousConnection:$previousConnection, hasConnection: $hasConnection');
//   if (previousConnection != hasConnection || !hasConnection) {
//     log.d('$runtimeType checkConnection() connectionChangeController.add(hasConnection: $hasConnection);');
//     connectionChangeController.add(hasConnection);
//   }else{
//     log.d('$runtimeType !!!!! ');
//     // todo uug ni duudah shaardlagagui
//     connectionChangeController.add(hasConnection);
//   }
//   log.d('$runtimeType  finish ');
//
//   return hasConnection;
// }
}
