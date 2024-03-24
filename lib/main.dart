import 'package:flutter/material.dart';
import 'package:flutter_application_1/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Dice Roller',
      home: Scaffold(
        backgroundColor: Colors.pink,
        body: GradientContainer(
          colors: [Colors.purple, Colors.pink],
        ),
      ),
    ),
  );
}
