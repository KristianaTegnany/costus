import 'package:costus/src/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  const Input(
      {super.key,
      required this.controller,
      this.obscureText = false,
      this.errorText,
      required this.hintText,
      this.onChanged,
      this.onEditingComplete,
      this.secured = false});

  final TextEditingController controller;
  final bool obscureText;
  final String? errorText;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final bool secured;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool obscureText = false;

  void toggleLock() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    obscureText = widget.secured == true || widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(0),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primary, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primary, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primary, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: border),
            borderRadius: BorderRadius.circular(5)),
        filled: true,
        fillColor: white,
        errorText: widget.errorText,
        hintText: widget.hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(widget.secured ? Icons.lock : Icons.email),
        ),
        suffixIcon: widget.secured
            ? IconButton(
                icon:
                    Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: toggleLock,
              )
            : null,
      ),
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}
