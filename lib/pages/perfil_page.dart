import 'package:flutter/material.dart';

import '../widgets/custom_bottom_navigation.dart';

class PerfilesPage extends StatelessWidget {
  const PerfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.mode_edit_outline)),
            Text('Perfil de Usuario')
          ],
        ),
      ),
      body: Center(
        child: Text('Perfil del usuario'),
      ),
      //bottomNavigationBar: CutomBottomNavigation(),
    );
  }
}
