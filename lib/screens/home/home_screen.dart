import 'package:flutter/material.dart';
import '../../core/utiles/calcultaor_logic.dart';
import './widgets/calculator_buttons.dart';
import './widgets/display_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String display = '';
  double? firstOperand;
  String? operator;

  void onButtonPressed(String value) {
    setState(() {
      if (['+', '-', '×', '÷'].contains(value)) {
        operator = value;
        firstOperand = double.tryParse(display);
        display = '';
      } else if (value == '=') {
        if (firstOperand != null && operator != null) {
          final second = double.tryParse(display) ?? 0;
          final result = CalculatorLogic.calculate(
            firstOperand!,
            second,
            operator!,
          );
          display = result.toString();
        }
      } else if (value == 'C') {
        display = '';
        firstOperand = null;
        operator = null;
      } else {
        display += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      '7',
      '8',
      '9',
      '÷',
      '4',
      '5',
      '6',
      '×',
      '1',
      '2',
      '3',
      '-',
      'C',
      '0',
      '=',
      '+',
    ];

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text('Akal Calculator'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DisplayPanel(value: display),
          GridView.builder(
            shrinkWrap: true,
            itemCount: buttons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            ),
            itemBuilder: (_, i) {
            final label = buttons[i];

              // 🎨 Button color logic
              Color bgColor;
              Color textColor = Colors.white;

              if (label == 'C') {
                bgColor = Colors.redAccent;
              } else if (label == '=') {
                bgColor = Colors.green;
              } else if (['+', '-', '×', '÷'].contains(label)) {
                bgColor = Colors.orange;
              } else {
                bgColor = Colors.grey[850]!;
              }

              return CalculatorButton(
                label: label,
                onPressed: () => onButtonPressed(label),
                backgroundColor: bgColor,
                textColor: textColor,
              );
            },
          ),
        ],
      ),
    );
  }
}
