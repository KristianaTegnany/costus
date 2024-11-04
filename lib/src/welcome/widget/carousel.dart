import 'package:carousel_slider/carousel_slider.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/spacer.dart';
import 'package:costus/src/widget/text.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem(
      {super.key,
      required this.index,
      required this.title,
      required this.description});

  final String title;
  final String description;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: primary,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(
          children: [
            Image.asset('assets/images/devices-$index.png'),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    title,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: CText(
                      description,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RectButton(
                    text: 'Learn More',
                    isPrimary: false,
                    onPress: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyCarousel extends StatefulWidget {
  const MyCarousel({super.key});

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            carouselController: _controller,
            items: const [
              CarouselItem(
                index: 1,
                title: 'Average Rate Overview',
                description:
                    'Our average rate page teach you, what is average rate calculation and how you can calculate it? This screen displays the average rate calculation results based on your selections for country, city, construction type, competition level, project size, and building type. It provides the labor rate per man hour and the material cost.',
              ),
              CarouselItem(
                index: 2,
                title: 'Difference Rate Overview',
                description:
                    'Our difference rate page teach you, what is difference rate calculation and how you can calculate it? This screen displays the difference rate calculation results based on your entry for labor hours, material cost, labor rate, profit on material, and add preliminaries. It provides the labor rate per man hour and the material cost.',
              ),
              CarouselItem(
                index: 3,
                title: 'm2 Rate Overview',
                description:
                    'Our m2 rate page teach you, what is m2 rate calculation and how you can calculate it? This screen displays the m2 rate calculation results based on your selections for country, city, construction type, competition level, project size, and building type. It provides the labor rate per man hour and the material cost.',
              ),
              CarouselItem(
                index: 4,
                title: 'Estimate on m2 Rate Overview',
                description:
                    'Our estimate on m2 rate page teach you, what is estimate on m2 rate calculation and how you can calculate it? This screen displays the estimate on m2 rate calculation results based on your selections for country, city, construction type, competition level, project size, and building type. It provides the labor rate per man hour and the material cost.',
              ),
            ],
            options: CarouselOptions(
                height: 370,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                })),
        const CSpacer(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [1, 2, 3, 4].asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        primary.withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
