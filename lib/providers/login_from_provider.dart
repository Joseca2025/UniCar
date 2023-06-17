import 'package:flutter/material.dart';

class LoginFormProvide extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isloading = false;
  bool get isLoading => _isloading;

  set isLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  bool isValidForm() {
    // aqui lo que hace es poner que puede retornar un false  o true
    return formKey.currentState?.validate() ?? false;
  }
}
