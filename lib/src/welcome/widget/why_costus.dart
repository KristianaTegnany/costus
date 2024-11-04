import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/spacer.dart';
import 'package:costus/src/widget/text.dart';
import 'package:flutter/material.dart';

class MyColoredBox extends StatelessWidget {
  const MyColoredBox({super.key, this.color, required this.width, this.height});

  final double width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
        color: color ?? primary,
        child: SizedBox(
          width: width,
          height: height ?? width,
        ));
  }
}

class CenterDot extends StatelessWidget {
  const CenterDot({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: Center(
        child: ClipOval(
          child: MyColoredBox(width: 7),
        ),
      ),
    );
  }
}

class ExtremeItem extends StatelessWidget {
  const ExtremeItem({super.key, this.isEnd});

  final bool? isEnd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          isEnd == true
              ? const MyColoredBox(
                  height: 20,
                  width: 1.5,
                )
              : const SizedBox(),
          const Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(
                child: MyColoredBox(
                  color: primaryTransparent,
                  width: 30,
                ),
              ),
              ClipOval(
                child: MyColoredBox(
                  width: 20,
                ),
              ),
            ],
          ),
          isEnd == true
              ? const SizedBox()
              : const MyColoredBox(
                  height: 20,
                  width: 1.5,
                )
        ],
      ),
    );
  }
}

class WhyCostusItem extends StatelessWidget {
  const WhyCostusItem(
      {super.key,
      this.isRight,
      required this.title,
      required this.subtitle,
      required this.image});

  final bool? isRight;
  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: isRight == true ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textDirection:
              isRight == true ? TextDirection.rtl : TextDirection.ltr,
          children: [
            SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: isRight == true
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  CText(
                    title,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const CSpacer(10),
                  CText(
                    subtitle,
                    textAlign:
                        isRight == true ? TextAlign.left : TextAlign.right,
                  )
                ],
              ),
            ),
            const CHSpacer(20),
            Image.asset(
              'assets/images/why/$image.png',
              width: 50,
              height: 50,
            ),
          ],
        ),
        Stack(
          children: [
            const CenterDot(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection:
                  isRight == true ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: isRight == true
                                  ? [primary, Colors.transparent]
                                  : [
                                      Colors.transparent,
                                      primary,
                                    ])),
                      child: const SizedBox(
                        height: 1.5,
                        width: 100,
                      ),
                    ),
                  ],
                ),
                const Center(
                  child: MyColoredBox(
                    height: 100,
                    width: 1.5,
                  ),
                ),
                const CHSpacer(100)
              ],
            ),
          ],
        ),
        const CHSpacer(250)
      ],
    );
  }
}

class WhyCostus extends StatelessWidget {
  const WhyCostus({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Latest Rates',
        'subtitle': 'Real time rates, anytime, all the time.',
        'image': 'rate',
        'isRight': false,
      },
      {
        'title': 'Available 24/7, 365',
        'subtitle': 'Access either via web or mobile.',
        'image': 'available',
        'isRight': true,
      },
      {
        'title': 'Multiple Choice',
        'subtitle':
            'You can vary the way you want the results based on your choices.',
        'image': 'choice',
        'isRight': false,
      },
      {
        'title': 'Industry Specific',
        'subtitle':
            'Specific rates for the mechanical, electrical and building.',
        'image': 'industry',
        'isRight': true,
      },
      {
        'title': 'UK Wide',
        'subtitle': 'All four countries of the UK.',
        'image': 'wide',
        'isRight': false,
      },
      {
        'title': 'Detailed Choice',
        'subtitle': 'Choose your trade, size, type and area of project.',
        'image': 'detail',
        'isRight': true,
      }
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ExtremeItem(),
        ...items.map((item) => WhyCostusItem(
              title: item['title']!,
              subtitle: item['subtitle']!,
              image: item['image']!,
              isRight: item['isRight']!,
            )),
        const ExtremeItem(isEnd: true),
      ],
    );
  }
}
