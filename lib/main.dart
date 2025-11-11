import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(ScientificCalculator());
}

class ScientificCalculator extends StatefulWidget {
  const ScientificCalculator({super.key});

  @override
  _ScientificCalculatorState createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  String _output = "0";
  String _expression = "";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";
  bool _isScientificMode = false;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
        _num1 = 0.0;
        _num2 = 0.0;
        _operand = "";
      } else if (buttonText == "⌫") {
        if (_output.length > 1) {
          _output = _output.substring(0, _output.length - 1);
        } else {
          _output = "0";
        }
      } else if (buttonText == "=") {
        _num2 = double.parse(_output);
        
        if (_operand == "+") {
          _output = (_num1 + _num2).toString();
        }
        if (_operand == "-") {
          _output = (_num1 - _num2).toString();
        }
        if (_operand == "×") {
          _output = (_num1 * _num2).toString();
        }
        if (_operand == "÷") {
          _output = (_num1 / _num2).toString();
        }
        if (_operand == "^") {
          _output = (pow(_num1, _num2)).toString();
        }
        
        _num1 = 0.0;
        _num2 = 0.0;
        _operand = "";
        _expression = "";
      } else if (buttonText == ".") {
        if (!_output.contains(".")) {
          _output = _output + buttonText;
        }
      } else if (buttonText == "±") {
        _output = (-double.parse(_output)).toString();
      } else if (["sin", "cos", "tan", "log", "ln", "√", "x²", "x³", "π", "e", "!"].contains(buttonText)) {
        _handleScientificFunction(buttonText);
      } else if (["+", "-", "×", "÷", "^"].contains(buttonText)) {
        _num1 = double.parse(_output);
        _operand = buttonText;
        _expression = _output + buttonText;
        _output = "0";
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output = _output + buttonText;
        }
      }
    });
  }

  void _handleScientificFunction(String function) {
    double number = double.parse(_output);
    double result = 0.0;
    
    switch (function) {
      case "sin":
        result = sin(number * pi / 180); // Convert to radians
        break;
      case "cos":
        result = cos(number * pi / 180);
        break;
      case "tan":
        result = tan(number * pi / 180);
        break;
      case "log":
        result = log(number) / ln10;
        break;
      case "ln":
        result = log(number);
        break;
      case "√":
        result = sqrt(number);
        break;
      case "x²":
        result = number * number;
        break;
      case "x³":
        result = number * number * number;
        break;
      case "π":
        result = pi;
        break;
      case "e":
        result = e;
        break;
      case "!":
        result = _factorial(number.toInt()).toDouble();
        break;
    }
    
    _output = result.toString();
    _expression = "$function($_output)";
  }

  int _factorial(int n) {
    if (n == 0 || n == 1) return 1;
    return n * _factorial(n - 1);
  }

  Widget _buildButton(String buttonText, {Color color = Colors.white, Color textColor = Colors.black}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(16),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Scientific Calculator'),
          backgroundColor: Colors.blue[800],
          actions: [
            IconButton(
              icon: Icon(_isScientificMode ? Icons.calculate : Icons.science),
              onPressed: () {
                setState(() {
                  _isScientificMode = !_isScientificMode;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            // Display area
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(fontSize: 18, color: Colors.grey[400]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _output,
                    style: TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Divider(color: Colors.grey),
            ),
            
            // Calculator buttons
            Column(
              children: [
                // First row
                Row(
                  children: [
                    _buildButton("C", color: Colors.red),
                    _buildButton("⌫", color: Colors.orange),
                    _buildButton("±", color: Colors.blue, textColor: Colors.white),
                    _buildButton("÷", color: Colors.blue, textColor: Colors.white),
                  ],
                ),
                
                // Second row
                Row(
                  children: [
                    if (_isScientificMode) _buildButton("sin", color: Colors.grey[700]!, textColor: Colors.white),
                    if (_isScientificMode) _buildButton("cos", color: Colors.grey[700]!, textColor: Colors.white),
                    if (_isScientificMode) _buildButton("tan", color: Colors.grey[700]!, textColor: Colors.white),
                    if (!_isScientificMode) _buildButton("7"),
                    if (!_isScientificMode) _buildButton("8"),
                    if (!_isScientificMode) _buildButton("9"),
                    _buildButton("×", color: Colors.blue, textColor: Colors.white),
                  ],
                ),
                
                // Third row
                Row(
                  children: [
                    if (_isScientificMode) _buildButton("log", color: Colors.grey[700]!, textColor: Colors.white),
                    if (_isScientificMode) _buildButton("ln", color: Colors.grey[700]!, textColor: Colors.white),
                    if (_isScientificMode) _buildButton("√", color: Colors.grey[700]!, textColor: Colors.white),
                    if (!_isScientificMode) _buildButton("4"),
                    if (!_isScientificMode) _buildButton("5"),
                    if (!_isScientificMode) _buildButton("6"),
                    _buildButton("-", color: Colors.blue, textColor: Colors.white),
                  ],
                ),
                
                // Fourth row
                Row(
                  children: [
                    if (_isScientificMode) _buildButton("x²", color: Colors.grey[700]!, textColor: Colors.white),
                    if (_isScientificMode) _buildButton("x³", color: Colors.grey[700]!, textColor: Colors.white),
                    if (_isScientificMode) _buildButton("^", color: Colors.grey[700]!, textColor: Colors.white),
                    if (!_isScientificMode) _buildButton("1"),
                    if (!_isScientificMode) _buildButton("2"),
                    if (!_isScientificMode) _buildButton("3"),
                    _buildButton("+", color: Colors.blue, textColor: Colors.white),
                  ],
                ),
                
                // Fifth row
                Row(
                  children: [
                    if (_isScientificMode) _buildButton("π", color: Colors.grey[700]!, textColor: Colors.white),
                    if (_isScientificMode) _buildButton("e", color: Colors.grey[700]!, textColor: Colors.white),
                    if (_isScientificMode) _buildButton("!", color: Colors.grey[700]!, textColor: Colors.white),
                    if (!_isScientificMode) _buildButton("0"),
                    if (!_isScientificMode) _buildButton("."),
                    _buildButton("=", color: Colors.green),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
