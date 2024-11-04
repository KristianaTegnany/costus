import 'package:costus/src/steps/competition/cubit/competitions_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/sample_text.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompetitionView extends StatelessWidget {
  const CompetitionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ResultCubit resultCubit = context.read<ResultCubit>();
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();
      final competition = context.watch<ResultCubit>().state.competition;

      return BlocProvider(
        create: (context) => CompetitionsCubit(),
        child: StepLayout(
          isWebChild: kIsWeb,
          onPress: () => stepNavigationCubit.onNextPressed(),
          buttonDisabled: competition == null,
          child: BlocBuilder<CompetitionsCubit, CompetitionsState>(
            builder: (context, state) {
              return Center(child: Builder(
                builder: (context) {
                  if (state is CompetitionsLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const StepImage('competition'),
                        MyTitle(
                          text: state.question ?? '',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: MyDropDown(
                            data: state.competitions ?? [],
                            label: state.placeholder ?? '',
                            value: competition,
                            onChange: (value) =>
                                resultCubit.onCompetitionChanged(value),
                          ),
                        ),
                        SampleText(text: state.sample ?? ''),
                      ],
                    );
                  }
                  return const CircularProgressIndicator(
                    color: background,
                  );
                },
              ));
            },
          ),
        ),
      );
    });
  }
}
