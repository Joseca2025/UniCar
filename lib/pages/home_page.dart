//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicar/pages/busca_viaje_page.dart';
import 'package:unicar/pages/historial_viaje_page.dart';
import 'package:unicar/pages/perfil_page.dart';
import 'package:unicar/providers/ui_provider.dart';
//import 'package:unicar/services/auth_service.dart';

import '../services/services.dart';
import '../widgets/custom_bottom_navigation.dart';
import 'pages.dart';

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
      body: _HomePageBody(),
      bottomNavigationBar: CutomBottomNavigation(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  //const _({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    //currentIndex
    switch (currentIndex) {
      case 0:
        return BuscarViajesPage();

      case 1:
        return PublicarViajesPage();

      case 2:
        return HistorialViajesPage();

      case 3:
        return PerfilesPage();

      default:
        return BuscarViajesPage();
    }
  }
}
