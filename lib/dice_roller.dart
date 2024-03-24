import 'package:flutter/material.dart';
import 'dart:math';

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
  final TextEditingController _guessController = TextEditingController();
  String _message = "";

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
      // Compare with the user's guess
      final userGuess = int.tryParse(_guessController.text);
      if (userGuess != null) {
        if (userGuess < 1 || userGuess > 6) {
          _message = "Enter a number between 1 and 6.";
        } else if (userGuess == newRoll) {
          _message = "You guessed right!";
        } else {
          _message = "You guessed wrong. It was $newRoll.";
        }
      } else {
        _message = "Please enter a valid number.";
      }
    });

    _controller.forward(from: 0); // Start the animation from 0 each time
  }

  @override
  void dispose() {
    _controller.dispose();
    _guessController.dispose();
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
      child: Image.asset('assets/image/dice-$currentDiceRoll.png', width: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //add padding to text field
        const Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Text("Dice Roller",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.yellow,
                    fontFamily: "Roboto"))),
        Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: SizedBox(
                width: 300,
                child: TextField(
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  controller: _guessController,
                  decoration: const InputDecoration(
                    labelText: "Enter your guess",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      // Used when the TextField is enabled and not focused
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color:
                              Colors.white), // Set border color to black here
                    ),
                    focusedBorder: OutlineInputBorder(
                      // Used when the TextField is focused
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color:
                              Colors.white), // Set border color to black here
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ))),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: _buildDiceImage(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(_message,
              style: const TextStyle(fontSize: 20, color: Colors.white)),
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
                    horizontal: 32, vertical: 15), // Adjust padding
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
