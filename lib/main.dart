import 'package:flutter/material.dart';
import 'package:unicar/pages/pages.dart';
import 'package:unicar/pages/register_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CarUni',
      initialRoute: 'login',
      routes: {
        'login':(_)=>LoginPage(),
        'register':(_)=>RegisterPage(),
        'home':(_)=>HomePage(),
      },   
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white24
      ),   
    );
  }
}
