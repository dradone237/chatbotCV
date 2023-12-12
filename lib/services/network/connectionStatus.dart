import 'dart:developer';
// import 'dart:io'; //InternetAddress utility
import 'dart:async'; //For StreamController/Stream

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionStatusSingleton {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatusSingleton _singleton =
      ConnectionStatusSingleton._internal();

  ConnectionStatusSingleton._internal();

  factory ConnectionStatusSingleton() {
    return _singleton;
  }

  ValueNotifier<bool> isServerConnected = ValueNotifier(false);
  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  void _connectionChange(ConnectivityResult result) async {
    print("_connectivity connection changed: $result");
    //if ConnectivityResult.none, there's no need to "check"
    if (result != ConnectivityResult.none) {
      await checkConnection();
    } else {
      isServerConnected.value = false;
    }
    log("Internet status ====== $isServerConnected");
  }

  Future<bool> checkConnection() async {
    isServerConnected.value = await InternetConnectionChecker().hasConnection;
    if (isServerConnected.value) {
      // Appel de l'api pour verifier si le serveur backeng est disponible
    }
    return isServerConnected.value;
  }

  //The test to actually see if there is a connection
  // Future<bool> checkConnection() async {
  //   bool previousConnection = hasConnection;

  //   List userData = await dbHelper.getUserTable();
  //   String requestUser = userData.isNotEmpty ? userData[0]['email'] : "";

  //   //I need Current Route and I need it to be  not null..
  //   String currentRoute = navigatorKey.currentState != null
  //       ? ModalRoute.of(navigatorKey.currentState!.context) != null
  //           ? ModalRoute.of(navigatorKey.currentState!.context)!.settings.name!
  //           : ""
  //       : "";

  //   /// <summary>
  //   /// this method checks if our API is up and returns notification-count.
  //   /// By calling this method, we get answers to;
  //   ///     - do I have connection?
  //   ///     - is my API up & running?
  //   ///     - do I have any unread notification?
  //   ///     - logs: deviceID, IP address and active on which page(app)
  //   /// </summary>
  //   ///
  //   String requestURL =
  //       "${apiURL}GetNotificationCount?dID=$deviceId&rU=$requestUser&p=$currentRoute";

  //   try {
  //     final response = await http
  //         .get(Uri.parse(requestURL))
  //         .timeout(const Duration(seconds: 3));

  //     if (response.statusCode == 200) {
  //       var responseDecode = json.decode(response.body);
  //       bildirimSayisi = int.parse(responseDecode.toString());

  //       notificationCountController.add(bildirimSayisi);

  //       print("Current notification count: $bildirimSayisi");
  //       hasConnection = true;
  //     } else {
  //       await dbHelper.insertLogBase(
  //           "No Internet", "checkConnection", "Connectivity");
  //       hasConnection = false;
  //     }
  //   } on TimeoutException catch (_) {
  //     await dbHelper.insertLogBase(
  //         "No Internet - TimeOut", "checkConnection", "Connectivity");
  //     hasConnection = false;
  //   } on SocketException catch (_) {
  //     await dbHelper.insertLogBase(
  //         "No Internet", "checkConnection", "Connectivity");
  //     hasConnection = false;
  //   }

  //   //The connection status changed send out an update to all listeners
  //   if (previousConnection != hasConnection) {
  //     connectionChangeController.add(hasConnection);
  //   }
  //   print("Am I Online? --->  $hasConnection");
  //   return hasConnection;
  // }
}

final connectionStatus = ConnectionStatusSingleton();
