import 'package:flutter/material.dart';
import 'dart:math';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;

  void rollDice() {
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1; // 0 <> 6
    });
    // print("Rolling " + activeDiceImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child:
              Image.asset('assets/image/dice-$currentDiceRoll.png', width: 200),
        ),
        // const SizedBox(height: 20),
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
                    horizontal: 32, vertical: 16), // Adjust padding
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
