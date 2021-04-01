import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.22,
      child: Image.asset('assets/bird.png',),
      //color: Colors.red,
    );
  }
}