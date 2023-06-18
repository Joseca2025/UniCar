import 'package:flutter/material.dart';

import '../widgets/custom_bottom_navigation.dart';

class HistorialViajesPage extends StatelessWidget {
  //const PerfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            //IconButton(onPressed: () {}, icon: Icon(Icons.mode_edit_outline)),
            Text('Historial de viajes')
          ],
        ),
      ),
      body: Center(
        child: Text('Historial de viajes'),
      ),
      //bottomNavigationBar: CutomBottomNavigation(),
    );
  }
}
