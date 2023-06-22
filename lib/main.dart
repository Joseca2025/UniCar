import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicar/models/models.dart';
import 'package:unicar/pages/busca_viaje_page.dart';
import 'package:unicar/pages/car_page.dart';
import 'package:unicar/pages/historial_viaje_page.dart';
import 'package:unicar/pages/pages.dart';
import 'package:unicar/pages/perfil_page.dart';
import 'package:unicar/pages/register_page.dart';
import 'package:unicar/providers/ui_provider.dart';
import 'package:unicar/services/auth_service.dart';
import 'package:unicar/services/services.dart';
import 'package:unicar/services/user_service.dart';
import 'package:unicar/temas/app_info.dart';

void main() => runApp(const MyApp());


/* class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UsersService())
      ],
      child: MyApp(),
    );
  }
}
 */


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        
        ChangeNotifierProvider(create: (_) => UiProvider()),
         ChangeNotifierProvider(create: (_) =>  AppInfo()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniCar',
        initialRoute: 'checking',
        routes: {
          'login': (_) => const LoginPage(),
          'register': (_) => const RegisterPage(),
          'home': (_) => const HomePage(),
          'checking': (_) => const CheckAuthPage(),
          'buscarviajes': (_) => const BuscarViajesPage(),
          'publicar': (_) => const HomeScreen(),
          'historial': (_) => HistorialViajesPage(),
          //'perfil': (_) => PerfilesPage(name: ,),
          'car': (_) => const CarsPage(),
        },
        scaffoldMessengerKey: NotificationsService.messgerkey,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255)),
        // Colors.white24
      ),
    );
  }
}
