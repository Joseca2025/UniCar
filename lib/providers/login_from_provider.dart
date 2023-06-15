import 'package:flutter/material.dart';

class LoginFormProvide extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String correo = '';
  String contrasena = '';

  bool isValidForm() {
    // aqui lo que hace es poner que puede retornar un false  o true
    return formKey.currentState?.validate() ?? false;
  }
}
