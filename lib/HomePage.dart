import 'dart:async';
import 'package:flappy_bird/Barrier.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = 'Home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle textStyleTitle = TextStyle(color: Colors.white, fontSize: 30);
  double heightUp = 0, heighDown = 0, score = 0, best = 0;
  double birdyaxis = 0, time=0, height = 0, initalHeight = 0, timer=0;
  double barrierxone = 1, barrierxtwo = 2;
  bool game = false;

  void jump() {
    setState(() {
      time = 0;
      initalHeight = birdyaxis;
    });
  }

  void startGame() {
    game = true;
    Timer.periodic(Duration(milliseconds: 60), (t) {
        timer += 0.5;
        time += 0.04;
        height = -4.9 * time * time + 2.8 * time;
        birdyaxis = initalHeight - height;
        if(timer>10.0){
          setState(() {
            heightUp = 0.2;
            heighDown = 0.2;
          });
        }
        if(timer>11.0){
          if (barrierxone < -1.1) {
            barrierxone += 2.2;
          } else {
            barrierxone -= 0.05;
          }
          if (barrierxtwo < -1.1) {
            barrierxtwo += 2.2;
          } else {
            barrierxtwo -= 0.05;
          }
          score +=0.05;
          if(score>best){
            best = score;
          }
        }
        //print(birdyaxis);
        if ((birdyaxis > 1.2 )|| (birdyaxis < -1.2)) {
          t.cancel();
          game = false;
          time = 0;
          timer = 0.0;
          birdyaxis = 0;
          initalHeight = 0;
          barrierxone = 1;
          barrierxtwo = 2;
          heightUp = 0.0;
          heighDown = 0.0;
          dialog(score);
          score=0.0;
        }
        setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (game) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdyaxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: Bird(),
                  ),
                  Container(
                      alignment: Alignment(0, -0.3),
                      child: (game)
                          ? Text("")
                          : Text("T A P  T O  P L A Y",
                              style: textStyleTitle)),
                  AnimatedContainer(
                    alignment: Alignment(barrierxone, 1.15),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      height: size.height * heightUp,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierxone, -1.15),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      height: size.height * heighDown,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierxtwo, 1.15),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      height: size.height * heightUp,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierxtwo, -1.15),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      height: size.height * heighDown,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("SCORE", style: textStyle),
                        SizedBox(
                          height: 20,
                        ),
                        Text("${score.round()}", style: textStyle),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("BEST", style: textStyle),
                        SizedBox(
                          height: 20,
                        ),
                        Text("${best.round()}", style: textStyle),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> dialog(double score) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('GAME OVER', style: textStyle),
          backgroundColor: Colors.brown,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('SCORE: ${score.round()}', style: textStyle),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('PLAY AGAIN', style: textStyle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
