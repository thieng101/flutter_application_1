import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller>
    with SingleTickerProviderStateMixin {
  var currentDiceRoll = 2;
  late AnimationController _controller;
  late Animation _diceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _diceAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void rollDice() {
    setState(() {
      currentDiceRoll = Random().nextInt(6) + 1; // Dice numbers go from 1 to 6
    });
    _controller.forward(from: 0); // Start the animation from 0 each time
  }

  Widget _buildDiceImage() {
    // Shadow effects can be adjusted to your liking for a 3D effect
    return AnimatedBuilder(
      animation: _diceAnimation,
      builder: (context, child) {
        // Adding a rotation effect on the dice roll
        final angle = _diceAnimation.value * pi * 2;
        return Transform.rotate(
          angle: angle,
          child: child,
        );
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(3, 6),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
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
          child: _buildDiceImage(), // Use the builder method for the dice image
        ),
        // The rest of your button code...
      ],
    );
  }
}
