import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../models/models.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _baseUrl2 = 'unicar-197b7-default-rtdb.firebaseio.com';
  final String _firebaseToken = 'AIzaSyD1uygl7Dj4VHp8ezCjNnIKSv0KyWcmqd0';
  final storage = const FlutterSecureStorage();
    User usershow=User(email: '', name: '', lastname: '', telefono: '', registro: 0, tipouser: '') ;
  Future<String?> createUser(
      String email,
      String password,
      String name,
      String lastname,
      String telefono,
      int registro,
      String tipouser,
      String? photoUrl,
      String? id) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final User usertemp = User(
        email: email,
        name: name,
        lastname: lastname,
        telefono: telefono,
        registro: registro,
        tipouser: tipouser);

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    //print(decodedResp);
    if (decodedResp.containsKey('idToken')) {
      //token guardar en un lugar seguro
      // decodedResp['idToken'];
      //return 'Error en el login';
      storage.write(key: 'token', value: decodedResp['idToken']);
      createUsers(usertemp);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});
    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    final emailUser = decodedResp['email'];

///aquie de abajo
    //final userT = await getUserByEmail(emailUser);
    //usershow = User.fromMap(userT);
    /* if (userT != null) {
      // Usuario encontrado
      print('Usuario encontrado: $userT');
      print(usershow.registro);
    } else {
      // Usuario no encontrado
      print('Usuario no encontrado');
    }

    print(decodedResp['email']); */

    if (decodedResp.containsKey('idToken')) {
      //token guardar en un lugar seguro
      // decodedResp['idToken'];
      await storage.write(key: 'token', value: decodedResp['idToken']);
      //await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

////////////////
/*   Future saveOrCreateProduct(User user) async {
    //notifyListeners();

    if (user.id == null) {
      // Es necesario crear
      await createUsers(user);
    }

    notifyListeners();
  } */

  Future<String> createUsers(User user) async {
    final url = Uri.https(_baseUrl2, 'user.json');
    final resp = await http.post(url, body: user.toJson());
    final decodedData = json.decode(resp.body);

    user.id = decodedData['name'];

    return user.id!;
  }

  Future<Map<String, dynamic>> getUserByEmail(String email) async {
    const url = 'https://unicar-197b7-default-rtdb.firebaseio.com/user.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> users = json.decode(response.body);

      // Buscar el usuario por correo electrónico
      final user = users.values.firstWhere(
        (user) => user['email'] == email,
        orElse: () => null,
      );

      return user;
    } else {
      throw Exception('Error al obtener los usuarios');
    }
  }
}
