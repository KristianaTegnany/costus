import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  final Size preferredSize;
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      iconTheme: const IconThemeData()
          .copyWith(color: Theme.of(context).colorScheme.primary),
      title: Image.asset(
        'assets/images/logo.png',
        width: 200,
      ),
      centerTitle: true,
    );
  }
}
