import 'package:costus/src/utils/subscription/subscription_func.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:flutter/material.dart';

class Subscribe extends StatelessWidget {
  const Subscribe({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                "Access the latest rates, all for a low cost subscription",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              )),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your Email",
                          filled: true,
                          fillColor: white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20)),
                    ),
                  ),
                ),
                RectButton(text: "Subscribe", onPress: presentPaywall)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
