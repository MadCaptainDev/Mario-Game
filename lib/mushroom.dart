import 'package:flutter/material.dart';

class MushRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      child: Transform.scale(
          scale: 2.5, child: Image.asset('lib/Assets/Mushroom.png')),
    );
  }
}
