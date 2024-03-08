import 'package:costus/src/widget/my_appbar.dart';
import 'package:flutter/material.dart';

class StepLayout extends StatelessWidget {
  const StepLayout(
      {super.key,
      required this.child,
      this.isChild = true,
      this.isWhite = false});

  final Widget child;
  final bool isWhite;
  final bool isChild;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isWhite
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.primary,
        appBar: isChild ? null : const MyAppBar(),
        body: Center(child: child));
  }
}
