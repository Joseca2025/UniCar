import 'package:flutter/material.dart';

class CutomBottomNavigation extends StatelessWidget {
  //const CutomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //para que se vea el nombre simpre abajo de los iconos
      //de comentar lo de abjo solo que se ve feo 
      //type: BottomNavigationBarType.fixed,
      selectedItemColor:Colors.blueAccent,
      backgroundColor: Colors.grey,
      unselectedIconTheme: IconThemeData(color: Color.fromRGBO(116, 117, 152, 1)),
      //currentIndex: 1,
      items:[
          BottomNavigationBarItem(icon: Icon(Icons.add_location_alt), label: 'Buscar viaje'),
          BottomNavigationBarItem(icon: Icon(Icons.add_road_outlined ),label: 'Publicar'),
           BottomNavigationBarItem(icon: Icon(Icons.directions_car_rounded ),label: 'Tus viajes'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined ), label: 'Perfil'),
      ]
      );
  }
}