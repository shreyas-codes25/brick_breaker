import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brick_breaker/elements/player.dart';
import 'package:brick_breaker/elements/start_screen.dart';
import '../elements/ball.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Ball
  double ballx = 0;
  double bally = 0;

  // Player
  double playerx = 0;
  double playerWidth = 0.4;

  bool hasStarted = false;

  void startGame() {
    hasStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        bally = bally + 0.001;
      });
    });
  }

  void moveLeft() {
    setState(() {
      if(!(playerx-0.02<=-1.0)) {
        playerx -= 0.02;
      }
    });
  }

  void moveRight() {
    setState(() {
      if(!(playerx+0.02>=1.0)) {
        playerx += 0.02;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => startGame(), // Start game when pointer is down
      onPointerMove: (event) {
        // Move player based on pointer movement
        if (event.delta.dx < 0) {
          moveLeft();
        } else if (event.delta.dx > 0) {
          moveRight();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.yellow],
                begin: Alignment.topLeft,
                end: Alignment.topCenter,
              ),
            ),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Stack(
            children: [
              // Tap to play
              startScreen(hasStarted: hasStarted),
              // Ball
              Ball(ballx: ballx, bally: bally),
              // Player
              Player(playerx: playerx, playerWidth: playerWidth),
            ],
          ),
        ),
      ),
    );
  }
}
