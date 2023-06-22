//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicar/models/models.dart';
import 'package:unicar/pages/busca_viaje_page.dart';
import 'package:unicar/pages/historial_viaje_page.dart';
import 'package:unicar/pages/perfil_page.dart';
import 'package:unicar/providers/ui_provider.dart';
//import 'package:unicar/services/auth_service.dart';

import '../services/services.dart';
import '../services/user_service.dart';
import '../widgets/custom_bottom_navigation.dart';
import 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.user});
  
   final User? user;
  //const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
   // final usersService = Provider.of<UsersService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.login_outlined),
              onPressed: () {
                // Lógica para cerrar sesión
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
            const SizedBox(width: 10),
            const Text('Home'),
          ],
        ),
      ),
      body: _HomePageBody(user: user,),
      bottomNavigationBar: CutomBottomNavigation(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({this.user});
    final User? user;
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    //final usersService = Provider.of<UsersService>(context);
    //currentIndex
    switch (currentIndex) {
      case 0:
        return const BuscarViajesPage();

      case 1:
        return const HomeScreen();

      case 2:
        return HistorialViajesPage();

      case 3:
        return   PerfilesPage(user: user);

      default:
        return const BuscarViajesPage();
    }
  }
}
