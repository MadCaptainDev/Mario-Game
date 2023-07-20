import 'dart:math';
import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  final direction;
  bool midrun;
  bool midjump;
  String checkMarioType;

  MyMario(
      {this.direction,
      required this.midrun,
      required this.midjump,
      required this.checkMarioType});

  @override
  Widget build(BuildContext context) {
    String marioType = checkMarioType == "SuperMario" ? "SuperMario" : "Mario";
    String asset = midjump
        ? 'lib/Assets/${marioType}Jump.png'
        : midrun
            ? 'lib/Assets/${marioType}Walk0.png'
            : 'lib/Assets/${marioType}.png';

    return SizedBox(
      width: 50,
      height: 50,
      child: direction == 'right'
          ? Transform.scale(
              scale: 2.8,
              child: Image.asset(
                asset,
              ))
          : Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: Transform.scale(
                  scale: 2.8,
                  child: Image.asset(
                    asset,
                  )),
            ),
    );
  }
}
