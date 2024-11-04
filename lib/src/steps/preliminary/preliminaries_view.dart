import 'package:costus/src/steps/home/home_view.dart';
import 'package:costus/src/steps/preliminary/cubit/preliminary_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreliminariesView extends StatelessWidget {
  const PreliminariesView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      isWebChild: kIsWeb,
      isFirst: true,
      child: Center(
          child: BlocBuilder<PreliminaryCubit, PreliminaryState>(
            builder: (context, state) {
              if(state is! PreliminaryInitial){
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const StepImage('preliminary'),
                    MyTitle(
                      isPrimary: true,
                      text:
                          state.title ?? '',
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: BlocBuilder<PreliminaryCubit, PreliminaryState>(
                            builder: (context, state) {
                          return Column(
                            children: [
                              OptionWidget(
                                isStart: true,
                                text: state.questionYes ?? '',
                                onPressed: () => context
                                    .read<PreliminaryCubit>()
                                    .onPreliminaryChosen(true),
                              ),
                              const SizedBox(
                                height: kIsWeb ? 40 : 20,
                              ),
                              OptionWidget(
                                  isStart: true,
                                  text: state.questionNo ?? '',
                                  onPressed: () => context
                                      .read<PreliminaryCubit>()
                                      .onPreliminaryChosen(false)),
                            ],
                          );
                        }))
                  ],
                );
              }
              return const CircularProgressIndicator(
                color: background,
              );
            },
          )),
    );
  }
}
