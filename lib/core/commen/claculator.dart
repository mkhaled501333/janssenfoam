import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SizedBox(
        height: 500,
        child: SimpleCalculator(
          theme: CalculatorThemeData(
            commandColor: Color.fromARGB(255, 187, 176, 142),
            displayColor: Colors.black,
            displayStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 80, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
