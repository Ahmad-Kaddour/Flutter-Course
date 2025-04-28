import 'package:first_app/dice_roller.dart';
import 'package:first_app/gradient_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          colors: [
            Color.fromARGB(255, 107, 65, 179),
            Color.fromARGB(255, 91, 13, 225),
          ],
          body: DiceRoller(),
        ),
      ),
    ),
  );
}
