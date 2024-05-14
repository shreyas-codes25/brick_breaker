import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final playerx;
  final playerWidth;
  const Player({super.key, this.playerx,this.playerWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2*playerx+playerWidth)/(2-playerWidth),0.9),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * playerWidth/2),


        child: Container(
          height: 15,
          width: MediaQuery.of(context).size.width * playerWidth/2,
          color: Colors.yellow,
        ),
      )
    );
  }
}
