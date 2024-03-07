import 'package:costus/src/questions/questions_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.isElectrical});

  final bool isElectrical;
  static const routeName = '/home_save';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void goToNext() {
    Navigator.pushNamed(context, QuestionsView.routeName,
        arguments: widget.isElectrical);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        iconTheme: const IconThemeData()
            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          'COSTUS',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.isElectrical ? 'ELECTRICAL' : 'MECHANICAL',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            FilledButton.icon(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 20))),
                onPressed: goToNext,
                icon: const Text('Continue'),
                label: const Icon(Icons.east))
          ],
        ),
      ),
    );
  }
}
