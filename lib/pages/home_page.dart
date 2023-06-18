//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:unicar/services/auth_service.dart';

import '../services/services.dart';
import '../widgets/custom_bottom_navigation.dart';

class HomePage extends StatelessWidget {
  //const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.login_outlined),
              onPressed: () {
                // Lógica para cerrar sesión
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
            SizedBox(width: 10),
            Text('Home'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home inicio'),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CutomBottomNavigation(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  //const _({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
