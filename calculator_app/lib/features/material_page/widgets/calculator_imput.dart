import 'package:flutter/material.dart';

class CalculatorInput extends StatelessWidget {
  const CalculatorInput({
    super.key,
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixText: 'м',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Введите значение';
        final num = double.tryParse(value);
        if (num == null || num <= 0) return 'Введите корректное число';
        return null;
      },
    );
  }
}
