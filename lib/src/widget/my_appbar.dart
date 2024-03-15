import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  final Size preferredSize;
}

class _MyAppBarState extends State<MyAppBar> {
  void onPress() {}

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      leading: BlocBuilder<StepNavigationCubit, StepNavigationState>(
          builder: (context, state) {
        if (state is! StepNavigationInitial) {
          return IconButton(
            iconSize: 40,
            icon: const Icon(Icons.chevron_left),
            onPressed: () =>
                context.read<StepNavigationCubit>().onPrevPressed(),
          );
        } else {
          return const SizedBox();
        }
      }),
      actions: [
        BlocBuilder<StepNavigationCubit, StepNavigationState>(
          builder: (context, state) {
            if (state is StepNavigationInitial) {
              return IconButton(
                iconSize: 25,
                icon: const Icon(Icons.logout),
                onPressed: () => FirebaseAuth.instance.signOut(),
              );
            } else {
              return const SizedBox();
            }
          },
        )
      ],
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
