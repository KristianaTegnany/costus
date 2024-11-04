import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/steps/type/cubit/types_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/sample_text.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeView extends StatelessWidget {
  const TypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ResultCubit resultCubit = context.read<ResultCubit>();
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();

      final type = context.watch<ResultCubit>().state.type;

      return BlocProvider(
        create: (context) => TypesCubit(),
        child: StepLayout(
          isWebChild: kIsWeb,
          onPress: () => stepNavigationCubit.onNextPressed(),
          buttonDisabled: type == null,
          child: BlocBuilder<TypesCubit, TypesState>(
            builder: (context, state) {
              return Center(
                  child: state is TypesLoaded
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const StepImage('type'),
                            MyTitle(
                              text: state.question ?? '',
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: MyDropDown(
                                data: state.types ?? [],
                                label: state.placeholder ?? '',
                                value: type,
                                onChange: (value) =>
                                    resultCubit.onTypeChanged(value),
                              ),
                            ),
                            SampleText(text: state.sample ?? ''),
                          ],
                        )
                      : const CircularProgressIndicator(
                          color: background,
                        ));
            },
          ),
        ),
      );
    });
  }
}
