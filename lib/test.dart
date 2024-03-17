import 'package:flutter/material.dart';
import 'package:flutter_application_1/styled_text.dart';

// Note: if I want to my app run the map as soon as the user open it,
// I could have a variable constant set it = to the function that will be called
// then the map will be called as soon as the user open the app
const startAlignment = Alignment.topRight;
const endAlignment = Alignment.bottomLeft;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        //use const here for Dark resue the code for memory optimization
        gradient: LinearGradient(
          begin: startAlignment,
          end: endAlignment,
          colors: [Colors.pink, Colors.purple],
        ),
      ),
      child: const StyledText("I love you ❤️"),
    );
  }
}
