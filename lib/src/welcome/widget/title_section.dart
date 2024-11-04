import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/welcome/widget/why_costus.dart';
import 'package:costus/src/widget/spacer.dart';
import 'package:costus/src/widget/text.dart';
import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.description});

  final String title;
  final String subtitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CSpacer(80),
        Row(
          children: [
            const MyColoredBox(
              width: 10,
              height: 60,
              color: primary,
            ),
            const CHSpacer(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  subtitle,
                  fontWeight: FontWeight.bold,
                ),
                CText(
                  title,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                )
              ],
            )
          ],
        ),
        const CSpacer(20),
        Align(
          alignment: AlignmentDirectional.topStart,
          child: SizedBox(
            width: 500,
            child: CText(
              description,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        const CSpacer(60),
      ],
    );
  }
}
