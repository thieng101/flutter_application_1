import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage = 'assets/image/dice-2.png';

  void rollDice() {
    setState(() {
      activeDiceImage = 'assets/image/dice-4.png';
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
          child: Image.asset(activeDiceImage, width: 200),
        ),
        // const SizedBox(height: 20),
        TextButton(
            onPressed: rollDice,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              // backgroundColor: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: const Text("Roll Dice"))
      ],
    );
  }
}
