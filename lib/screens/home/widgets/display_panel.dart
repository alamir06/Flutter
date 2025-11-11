import 'package:flutter/material.dart';

class DisplayPanel extends StatelessWidget {
  final String value;

  const DisplayPanel({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Text(
        value,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
