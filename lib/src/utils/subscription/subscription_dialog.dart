import 'package:costus/src/widget/rounded_button.dart';
import 'package:flutter/material.dart';

Future<void> onChangeAccountType(
    BuildContext context, String value, void Function() callback) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Need to upgrade'),
          content: Text(
              "You should upgrade your subscription to be able to access ${value == "1:1" ? "Mechanical" : (value == "2:2" ? "Electrical" : "Building")} data."),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RoundedButton(
              text: "Upgrade",
              onPress: () {
                Navigator.of(context).pop();
                callback();
              },
            ),
          ],
        );
      });
}
