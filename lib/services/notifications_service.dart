import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messgerkey =
      new GlobalKey<ScaffoldMessengerState>();
  static showSnackbar(String message) {
    final snackBar = SnackBar(
        content: Text(
      message,
      style: TextStyle(color: Colors.amber, fontSize: 30),
    ));
    messgerkey.currentState!.showSnackBar(snackBar);
  }
}
