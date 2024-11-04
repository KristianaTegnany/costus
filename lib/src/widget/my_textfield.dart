import 'package:costus/src/utils/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomPercentFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return const TextEditingValue().copyWith(text: '0');
    }

    return int.parse(newValue.text) > 100
        ? const TextEditingValue().copyWith(text: '100')
        : newValue;
  }
}

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
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: SizedBox(
        width: kIsWeb ? 400 : double.infinity,
        child: TextFormField(
            autofocus: true,
            initialValue: value,
            textAlign: isPercent
                ? TextAlign.end
                : isCurrency
                    ? TextAlign.start
                    : TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                prefixIcon: isCurrency
                    ? const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          "£",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    : null,
                suffixIcon: isPercent ? const Icon(Icons.percent) : null,
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: border)),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: border)),
                filled: true,
                fillColor: white,
                hintText: label),
            inputFormatters: isNumber || isCurrency
                ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
                : isPercent
                    ? [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d\.?\d{0,2}')),
                        CustomPercentFormatter()
                      ]
                    : null,
            keyboardType: isNumber || isCurrency || isPercent
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
            readOnly: FirebaseAuth.instance.currentUser == null,
            onChanged: (value) {
              if (isPercent) {
                if (int.parse(value) > 100) {}
              }
              onChange(value);
            }),
      ),
    );
  }
}
