import 'package:costus/src/cubit/preliminary_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreliminariesView extends StatelessWidget {
  const PreliminariesView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      child: Center(child: BlocBuilder<PreliminaryCubit, PreliminaryState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyTitle(
                text: "Do you want to add Preliminaries?",
                hasBackground: true,
              ),
              const SizedBox(
                height: 40,
              ),
              RectButton(
                  text: 'Yes',
                  onPress: () => context
                      .read<PreliminaryCubit>()
                      .onPreliminaryChoosen(true)),
              const SizedBox(
                height: 20,
              ),
              RectButton(
                  text: 'No',
                  onPress: () => context
                      .read<PreliminaryCubit>()
                      .onPreliminaryChoosen(false)),
            ],
          );
        },
      )),
    );
  }
}
