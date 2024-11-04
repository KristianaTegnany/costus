import 'package:costus/src/steps/layout/web_layout.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/welcome/welcome_view.dart';
import 'package:costus/src/welcome/widget/carousel.dart';
import 'package:costus/src/welcome/widget/testimonial.dart';
import 'package:costus/src/welcome/widget/title_section.dart';
import 'package:costus/src/welcome/widget/why_costus.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/spacer.dart';
import 'package:flutter/material.dart';

class WelcomeWebView extends StatelessWidget {
  const WelcomeWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      background: white,
      title:
          'Transforming Contractor Workflows\n with Essential Data Streams',
      subtitle:
          'Discover how Costus provides invaluable technical insights to optimize your project planning and execution, revolutionizing your workflow.',
      children: [
        RectButton(
            text: 'Get Started',
            onPress: () {
              Navigator.pushNamed(context, '/step',
                  arguments: StepArgs(isGetstarted: true));
            }),
        const CSpacer(80),
        const TitleSection(
          title: 'Why Choose COSTUS?',
          subtitle: 'Choose Wisely',
          description:
              'Discover how Costus provides invaluable technical insights to optimize your project planning and execution, revolutionizing your workflow.',
        ),
        const WhyCostus(),
        const CSpacer(40),
        const MyCarousel(),
        const TitleSection(
          title: 'Our Testimonials',
          subtitle: 'User Experiences',
          description:
              'Our clients share their success stories, showcasing the real impact of COSTUS on their project planning and execution.',
        ),
        const Row(
          children: [
            Testimonial(
                title: 'A Great Tool',
                description:
                    '"We have projects in more than one area so the ability to change area and type of project is invaluable."',
                author: 'Steeve W.'),
            Testimonial(
                title: 'Easy To Use',
                description:
                    '"It\'s really good at drilling down to specifics. Made our life a lot easier, both in the office and out."',
                author: 'Dan H.'),
            Testimonial(
                title: 'Great Value',
                description:
                    '"No more long calculations, very easy to use. Saved us a fortune."',
                author: 'David M.'),
          ],
        ),
      ],
    );
  }
}