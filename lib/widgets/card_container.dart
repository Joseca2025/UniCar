import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({super.key, required this.child});

  //const CardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
      //  height: 300,
      padding: EdgeInsets.all(20),
        decoration: _createcardshape(),
        child: this.child,
      ),
    );
  }

  BoxDecoration _createcardshape() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 10),
            )
          ]);
}
