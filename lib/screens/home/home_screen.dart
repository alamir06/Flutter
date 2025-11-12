import 'package:flutter/material.dart';
import '../../core/utiles/calcultaor_logic.dart';
import './widgets/calculator_buttons.dart';
import './widgets/display_panel.dart';
import './widgets/common_button.dart';

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
          // Primary Blue Button
          AppButton(
            text: 'Add Item',
            onPressed: () {},
            type: ButtonType.primary,
          ),

          SizedBox(height: 16),

          // Red Danger Button
          AppButton(text: 'Delete', onPressed: () {}, type: ButtonType.danger),

          SizedBox(height: 16),

          // Outlined Button
          AppButton(
            text: 'Cancel',
            onPressed: () {},
            type: ButtonType.secondary,
          ),

          SizedBox(height: 16),

          // Text Button
          AppButton(
            text: 'Learn More',
            onPressed: () {},
            type: ButtonType.text,
          ),

          SizedBox(height: 16),

          // Button with icon
          AppButton(
            text: 'Start Learning',
            onPressed: () {},
            prefixIcon: Icon(Icons.play_arrow, size: 20),
            type: ButtonType.primary,
          ),

          SizedBox(height: 16),

          // Loading state
          AppButton(
            text: 'Processing',
            onPressed: () {},
            isLoading: true,
            type: ButtonType.primary,
          ),

          SizedBox(height: 16),

          // Full width button
          AppButton(
            text: 'Submit',
            onPressed: () {},
            fullWidth: true,
            type: ButtonType.primary,
          ),

          SizedBox(height: 16),

          // Custom color
          AppButton(
            text: 'Custom Color',
            onPressed: () {},
            customColor: Colors.purple,
            textColor: Colors.white,
            type: ButtonType.primary,
          ),

          SizedBox(height: 16),

          // Different sizes
          AppButton(
            text: 'Small',
            onPressed: () {},
            size: ButtonSize.small,
            type: ButtonType.primary,
          ),
          DisplayPanel(value: display),
          GridView.builder(
            shrinkWrap: true,
            itemCount: buttons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (_, i) {
              final label = buttons[i]; // 🎨 Button color logic
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
