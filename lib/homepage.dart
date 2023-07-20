import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mariobros/button.dart';
import 'package:mariobros/mario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mariobros/mushroom.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool midrun = false;
  bool midjump = false;
  static bool mushroomEaten = false;
  static double marioX = 0;
  static double marioY = mushroomEaten ? 0.95 : 1;
  double mushroomX = 0.5;
  double mushroomY = 1;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = 'right';
  var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, fontSize: 20));

  void resetGame() {
    setState(() {
      midrun = false;
      midjump = false;
      mushroomEaten = false;
      marioX = 0;
      marioY = mushroomEaten ? 0.95 : 1;
      mushroomX = 0.5;
      mushroomY = 1;
      time = 0;
      height = 0;
      initialHeight = marioY;
      direction = 'right';
    });
  }

  void checkIfAteMushroom() {
    if ((marioX - mushroomX).abs() < 0.05 &&
        (marioY - mushroomY).abs() < 0.05) {
      setState(() {
        mushroomEaten = true;
        //Move mushroom off the screen
        mushroomX = 2;
        if (marioY == 1) {
          marioY = 0.95;
        }
      });
    }
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    // Disables double jump
    if (!midjump) {
      setState(() {
        midjump = true;
      });
      preJump();
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          setState(() {
            marioY = mushroomEaten ? 0.95 : 1;
            timer.cancel();
            midjump = false;
          });
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = 'right';
    checkIfAteMushroom();

    Timer.periodic(Duration(milliseconds: 50), ((timer) {
      checkIfAteMushroom();
      if (MyButton().userIsHoldingButton() == true && marioX + 0.02 < 1) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    }));
  }

  void moveLeft() {
    direction = 'left';
    checkIfAteMushroom();

    Timer.periodic(Duration(milliseconds: 50), ((timer) {
      checkIfAteMushroom();
      if (MyButton().userIsHoldingButton() == true && marioX - 0.02 > -1) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    color: Colors.blue,
                    child: AnimatedContainer(
                      alignment: Alignment(marioX, marioY),
                      duration: Duration(milliseconds: 0),
                      child: MyMario(
                        direction: direction,
                        midrun: midrun,
                        midjump: midjump,
                        checkMarioType: mushroomEaten ? "SuperMario" : "Mario",
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment(mushroomX, mushroomY),
                      child: MushRoom()),

                  Container(
                      alignment: Alignment(mushroomX -200, mushroomY),
                      child: MushRoom()),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "MARIO",
                              style: gameFont,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "0000",
                              style: gameFont,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "WORLD",
                              style: gameFont,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "1-1",
                              style: gameFont,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "TIME",
                              style: gameFont,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "9999",
                              style: gameFont,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.brown,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyButton(
                          function: moveLeft,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        MyButton(
                          function: jump,
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        ),
                        MyButton(
                          function: moveRight,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    MyButton(
                      function: resetGame,
                      child: Text(
                        "RESET",
                        style: gameFont,
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
