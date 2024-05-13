import  'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final ballx ;
  final bally ;
  const Ball({super.key, this.ballx, this.bally});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballx, bally),
      child: Container(
        height: 15,
        width: 15,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
