import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicar/pages/pages.dart';
import 'package:unicar/pages/register_page.dart';
import 'package:unicar/services/auth_service.dart';
import 'package:unicar/services/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniCar',
        initialRoute: 'checking',
        routes: {
          'login': (_) => LoginPage(),
          'register': (_) => RegisterPage(),
          'home': (_) => HomePage(),
          'checking': (_) => CheckAuthPage(),
        },
        scaffoldMessengerKey: NotificationsService.messgerkey,
        theme:
            ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white24),
      ),
    );
  }
}
