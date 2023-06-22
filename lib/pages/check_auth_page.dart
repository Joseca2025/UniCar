import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicar/pages/home_page.dart';
import 'package:unicar/pages/login_page.dart';
import 'package:unicar/services/services.dart';

class CheckAuthPage extends StatelessWidget {
  const CheckAuthPage({super.key});

//  const name({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) return const Text('Espere');

          if (snapshot.data == '') {
            Future.microtask(() {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const LoginPage(),
                      transitionDuration: const Duration(seconds: 0)));
            });
          } else {
            Future.microtask(() async {
              final user = await authService.readUser();
              print(user);
            
              if (context.mounted) {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomePage(user: user,),
                        transitionDuration: const Duration(seconds: 0)));
              }
            });
          }

          return Container();
        },
      ),
    );
  }
}
