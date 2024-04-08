import 'package:costus/src/welcome/welcome_view.dart';
import 'package:costus/src/widget/my_appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StepLayout extends StatelessWidget {
  const StepLayout(
      {super.key,
      required this.child,
      this.isChild = true,
      this.isWhite = false});

  final Widget child;
  final bool isWhite;
  final bool isChild;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isWhite
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.primary,
        appBar: isChild ? null : const MyAppBar(),
        bottomNavigationBar: kIsWeb &&
                (isChild ||
                    ModalRoute.of(context)?.settings.name ==
                        WelcomeView.routeName)
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Copyright © 2024',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: isWhite
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onPrimary),
                ),
              )
            : null,
        body: Center(child: child));
  }
}
