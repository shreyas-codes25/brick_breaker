import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final bool isOver;
  const GameOverScreen({super.key, required this.isOver});

  @override
  Widget build(BuildContext context) {
    return isOver? Container(
      alignment: const Alignment(0, -0.3),
      child: const Text("Game Over",style: TextStyle(color: Colors.black,fontSize: 20),),
    ):Container();
  }
}
