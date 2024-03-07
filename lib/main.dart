import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.pink,
        body: GradientContainer(),
      ),
    ),
  );
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        //use const here for Dark resue the code for memory optimization
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.pink, Colors.purple],
        ),
      ),
      child: Center(
        child: Text("Hello World",
            style: TextStyle(fontSize: 28, color: Colors.white)),
      ),
    );
  }
}
