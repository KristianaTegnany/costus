import 'package:costus/src/widget/rounded_button.dart';
import 'package:flutter/widgets.dart';

class Subscribe extends StatelessWidget {
  const Subscribe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 10),
            child: Text(
              "Access the latest rates, all for a low cost subscription",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        RoundedButton(text: "Subscribe here", animate: true, onPress: () {})
      ],
    );
  }
}
