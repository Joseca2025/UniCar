import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messgerkey =
      new GlobalKey<ScaffoldMessengerState>();
  static showSnackbar(String message) {
    final snackBar = SnackBar(
        content: Text(
      message='Usario incorrecto',
      style: TextStyle(color: Colors.redAccent, fontSize: 30),
    ));
    messgerkey.currentState!.showSnackBar(snackBar);
  }
}
