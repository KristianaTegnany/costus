import 'package:costus/src/widget/my_appbar.dart';
import 'package:costus/src/widget/outlined_button.dart';
import 'package:costus/src/widget/rounded_button.dart';
import 'package:costus/src/questions/questions_view.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.isElectrical});

  final bool isElectrical;
  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void goToNext() {
    Navigator.pushNamed(context, QuestionsView.routeName,
        arguments: widget.isElectrical);
  }

  void onAveragePressed() {}
  void onDifferencePressed() {}
  void onM2Pressed() {}
  void onEstimatePressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyTitle(text: 'Which rate shall I use?'),
            MyOutlinedButton(text: 'Average Rate?', onPress: onAveragePressed),
            const SizedBox(
              height: 10,
            ),
            MyOutlinedButton(
                text: 'Difference Rate?', onPress: onDifferencePressed),
            const SizedBox(
              height: 10,
            ),
            MyOutlinedButton(text: 'm2 Rate?', onPress: onM2Pressed),
            const SizedBox(
              height: 10,
            ),
            MyOutlinedButton(
                text: 'Estimate on m2 Rate?', onPress: onEstimatePressed),
          ],
        ),
      ),
    );
  }
}
