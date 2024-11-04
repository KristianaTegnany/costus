import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SharedBlocProvider<T extends BlocBase> extends StatelessWidget {
  final T Function(BuildContext) create;
  final Widget child;

  const SharedBlocProvider(
      {super.key, required this.create, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: create,
      child: child,
    );
  }
}
