import 'dart:async';
import 'package:brick_breaker/elements/brick.dart';
import 'package:brick_breaker/pages/gameoverscreen.dart';
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

enum direction { UP, DOWN, LEFT, RIGHT }

class _MyHomePageState extends State<MyHomePage> {
  // Ball
  double ballx = 0;
  double bally = 0;
  double ballXIncrement  = 0.01;
  double ballYIncrement  = 0.01;
  var ballXDirection = direction.LEFT;
  var ballYDirection = direction.DOWN;
  // Player
  double playerx = 0;
  double playerWidth = 0.5;

  //game status
  bool isGameOver = false;
  bool hasStarted = false;

  //brick
  double brickX = 0;
  double brickY = -0.9;
  double brickWidth = 0.4;
  double brickHeight = 0.05;
  bool brickBroken = false;

  void startGame() {
    if (!hasStarted) {
      hasStarted = true;

       Timer.periodic(const Duration(milliseconds: 10), (timer) {
        updateDirection();
        moveBall();

        if (isPlayerDead()) {
          timer.cancel();
          isGameOver = true;
        }
        checkForBrickBroken();
      });
    }
  }

  bool isPlayerDead() {
    if (bally >= 1) {
      return true;
    }
    return false;
  }

  void checkForBrickBroken() {
    if (bally >= brickY &&
        bally <= brickY + brickHeight &&
        ballx >= brickX &&
        ballx <= brickX + brickWidth &&
        brickBroken == false
    ) {
      setState(() {
        brickBroken = true;
      });
    }
  }

  void moveLeft() {
    setState(() {
      if (!(playerx - 0.02 <= -1.0)) {
        playerx -= 0.02;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerx + playerWidth >= 1.0)) {
        playerx += 0.02;
      }
    });
  }

  void moveBall() {
    setState(() {
      if (ballXDirection == direction.LEFT) {
        ballx -= ballXIncrement;
      } else if (ballXDirection == direction.RIGHT) {
        ballx += ballXIncrement;
      }

      if (ballYDirection == direction.DOWN) {
        bally += ballYIncrement;
      } else if (ballYDirection == direction.UP) {
        bally -= ballYIncrement;
      }
    });
  }

  void updateDirection() {
    setState(() {
      //left right

      if (ballx >= 1) {
        ballXDirection = direction.LEFT;
      }
      else if (ballx <= -1) {
        ballXDirection = direction.RIGHT;
      }
      // up down
      if (bally >= 0.9 && ballx >= playerx && ballx <= playerx + playerWidth) {
        ballYDirection = direction.UP;
      } else if (bally <= -0.9) {
        ballYDirection = direction.DOWN;
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
              //game over
              GameOverScreen(isOver: isGameOver),

              // Ball
              Ball(ballx: ballx, bally: bally),
              // Player
              Player(playerx: playerx, playerWidth: playerWidth),

              //bricks
              Brick(
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickX: brickX,
                  brickY: brickY,
                  brickBroken: brickBroken),
            ],
          ),
        ),
      ),
    );
  }
}
