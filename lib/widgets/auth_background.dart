import 'package:flutter/material.dart';

class AuthBackgroup extends StatelessWidget {
  //const AuthBackgroup({super.key});
  final Widget child;

  const AuthBackgroup({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueAccent,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _BlueBox(),
          _logodelogin(),
          this.child,
        ],
      ),
    );
  }
}

class _logodelogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 30),
            child: Icon(
              Icons.person_pin,
              color: Colors.white,
              size: 120,
            ),
          ),
          SizedBox(height: 10), // Espacio entre el logo y el botón de la cámara
          ElevatedButton(
            onPressed: () {
              // Acción al presionar el botón de la cámara
              // Aquí puedes agregar la lógica para subir fotos
            },
            child: Icon(Icons.camera_alt_rounded),
          ),
        ],
      ),
    );
  }
}

class _BlueBox extends StatelessWidget {
  const _BlueBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _azulfondo(),
      child: Stack(
        children: [
          //_pelotas()
          Positioned(
            child: _pelotas(),
            top: 90,
            left: 30,
          ),
          Positioned(
            child: _pelotas(),
            top: -40,
            left: -30,
          ),
          Positioned(
            child: _pelotas(),
            top: -50,
            right: -20,
          ),
          Positioned(
            child: _pelotas(),
            bottom: -50,
            left: 10,
          ),
          Positioned(
            child: _pelotas(),
            bottom: 120,
            right: 20,
          ),
        ],
      ),
    );
  }

  BoxDecoration _azulfondo() => BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blueAccent,
        Colors.blue,
      ]));
}

class _pelotas extends StatelessWidget {
  //const pelotas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
