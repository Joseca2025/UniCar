/*  import 'package:flutter/material.dart';

import '../models/user.dart';
import 'auth_service.dart';
//import '../resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthService _authMethods = AuthService();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}  */

 import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class UsersService extends ChangeNotifier {
  final String _baseurl = 'unicar-197b7-default-rtdb.firebaseio.com';
  // FirebaseAuth _auth = FirebaseAuth.instance;
  final List<User> usuarios = [];
  bool isLoading = true;

  UsersService() {
    loadUsers();
  }

  Future<List<User>> loadUsers() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseurl, 'users.json');
    final resp = await http.get(url);

    final Map<String, dynamic> usersMap = json.decode(resp.body);

    usersMap.forEach((key, value) {
      final temUser = User.fromMap(value);
      temUser.id = key;
      usuarios.add(temUser);
    });

    isLoading = false;
    notifyListeners();
    return usuarios;
  }
}
 
