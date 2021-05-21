import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  
  final double height;
  Barrier({@required this.height});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.25,
      height: height,
      decoration: BoxDecoration(
        color:Colors.green,
        border: Border.all(width:10, color:Colors.green[800]),
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}