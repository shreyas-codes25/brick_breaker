import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final brickWidth;
  final brickHeight;
  final brickX;
  final brickY;
  final brickBroken;
  const Brick(
      {super.key,
      required this.brickWidth,
      required this.brickHeight,
      required this.brickX,
      required this.brickY,
      required this.brickBroken});

  @override
  Widget build(BuildContext context) {
    return brickBroken ? Container() : Container(
      alignment: Alignment(brickX, brickY),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: MediaQuery.of(context).size.height * brickHeight / 2,
            width: MediaQuery.of(context).size.width * brickWidth / 2,
            color: Colors.black,
          )),
    );
  }
}
