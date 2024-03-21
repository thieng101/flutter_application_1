import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: DiceRoller(),
        ),
      ),
    );
  }
}

class DiceRoller extends StatefulWidget {
  const DiceRoller({Key? key}) : super(key: key);

  @override
  _DiceRollerState createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller>
    with SingleTickerProviderStateMixin {
  int currentDiceRoll = 1;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _rotationAnimation = Tween(begin: 0.0, end: pi * 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  void rollDice() {
    int newRoll;
    do {
      newRoll = Random().nextInt(6) + 1; // Dice numbers go from 1 to 6
    } while (newRoll == currentDiceRoll);

    setState(() {
      currentDiceRoll = newRoll; // Update the state with the new different roll
    });

    _controller.forward(from: 0); // Start the animation from 0 each time
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDiceImage() {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        final rotationAngle = _rotationAnimation.value;
        return Transform.rotate(
          angle: rotationAngle,
          child: child,
        );
      },
      child: Container(
        width: 200,
        height: 200,
        child: Image.asset('assets/image/dice-$currentDiceRoll.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _buildDiceImage(),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                30), // Match container's border radius with button
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.yellow,
                Color.fromARGB(255, 241, 88, 77),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 5), // Changes position of shadow
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: rollDice,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              // More properties here...
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              elevation: MaterialStateProperty.all(
                  0), // Disable elevation for button, it's on the container
              foregroundColor: MaterialStateProperty.all(Colors.black),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  fontSize: 24, // Adjust font size here
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(
                    horizontal: 25, vertical: 10), // Adjust padding
              ),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: const Text("Roll Dice"),
          ),
        )
      ],
    );
  }
}
