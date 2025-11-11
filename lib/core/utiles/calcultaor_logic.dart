class CalculatorLogic {
  static double calculate(double a, double b, String operator) {
    switch (operator) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        return b != 0 ? a / b : double.nan;
      default:
        return 0;
    }
  }
}
