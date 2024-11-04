import 'package:costus/src/steps/add/cubit/add_cubit.dart';
import 'package:costus/src/steps/home/home_view.dart';
import 'package:costus/src/steps/preliminary/cubit/preliminary_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  onPress(
      PreliminaryCubit preliminaryCubit, ResultCubit resultCubit, bool add) {
    preliminaryCubit.onPreliminaryChoiceChosen(add);
    resultCubit.onIsAmountChanged(add);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      PreliminaryCubit preliminaryCubit = context.read<PreliminaryCubit>();
      ResultCubit resultCubit = context.read<ResultCubit>();

      return BlocProvider(
        create: (context) => AddCubit(),
        child: StepLayout(
          isWebChild: kIsWeb,
          isFirst: true,
          child: Center(child: BlocBuilder<AddCubit, AddState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const StepImage('add'),
                  MyTitle(
                    isPrimary: true,
                    text: state.title ?? '',
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        OptionWidget(
                            isStart: true,
                            text: state.questionPercentage ?? '',
                            onPressed: () =>
                                onPress(preliminaryCubit, resultCubit, false)),
                        const SizedBox(
                          height: kIsWeb ? 40 : 20,
                        ),
                        OptionWidget(
                            isStart: true,
                            text: state.questionAmount ?? '',
                            onPressed: () =>
                                onPress(preliminaryCubit, resultCubit, true)),
                      ],
                    ),
                  )
                ],
              );
            },
          )),
        ),
      );
    });
  }
}
