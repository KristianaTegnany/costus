import 'package:flutter/material.dart';

class CSpacer extends StatelessWidget {
  const CSpacer(this.dimension, {super.key, this.horizontal});

  final bool? horizontal;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: horizontal == true ? null : dimension,
      width: horizontal == true ? dimension : null,
    );
  }
}

class CHSpacer extends CSpacer {
  const CHSpacer(super.dimension, {super.key}) : super(horizontal: true);
}
