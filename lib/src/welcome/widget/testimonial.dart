import 'package:costus/src/widget/spacer.dart';
import 'package:costus/src/widget/text.dart';
import 'package:flutter/material.dart';

class Testimonial extends StatelessWidget {
  const Testimonial(
      {super.key,
      required this.title,
      required this.description,
      required this.author});

  final String title;
  final String description;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/testimonial.png',
          width: 260,
          height: 260,
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CText(
                  title,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                const CSpacer(10),
                SizedBox(
                  height: 55,
                  child: CText(
                    description,
                    textAlign: TextAlign.center,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const CSpacer(10),
                CText(
                  author,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
