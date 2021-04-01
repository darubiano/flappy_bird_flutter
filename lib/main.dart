import 'package:flappy_bird/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      title: 'flappy bird',
      theme: ThemeData(
        primaryColor:Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (BuildContext context)=> HomePage(),
      },
    );
  }
}