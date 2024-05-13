import 'package:flutter/material.dart';


class startScreen extends StatelessWidget {
  final bool hasStarted;
  const startScreen({super.key, required this.hasStarted});

  @override
  Widget build(BuildContext context) {
    return hasStarted? Container(): Container(
       alignment:const Alignment(0, -0.2),
       child: const Text('Tap to play',style: TextStyle(color: Colors.black,fontSize: 20),),
     );
  }
}
