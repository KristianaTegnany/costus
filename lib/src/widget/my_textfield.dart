import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      this.isCurrency = false,
      this.isNumber = false,
      this.isPercent = false,
      required this.value,
      required this.label,
      required this.onChange});

  final bool isCurrency;
  final bool isNumber;
  final bool isPercent;
  final String? value;
  final String label;
  final void Function(String? value) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: TextField(
        autofocus: true,
        textAlign: isPercent ? TextAlign.end : TextAlign.start,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground),
        decoration: InputDecoration(
            prefixIcon: isCurrency ? const Icon(Icons.attach_money) : null,
            suffixIcon: isPercent ? const Icon(Icons.percent) : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Theme.of(context).colorScheme.background,
            hintText: label),
        inputFormatters: isNumber || isCurrency || isPercent
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
            : null,
        keyboardType: isNumber || isCurrency || isPercent
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        onChanged: (value) => onChange(value),
      ),
    );
  }
}
