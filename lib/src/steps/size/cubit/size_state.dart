part of 'size_cubit.dart';

@immutable
sealed class SizeState {
  const SizeState();
}

final class SizeInitial extends SizeState {}

final class SizeChosen extends SizeState {
  const SizeChosen({required this.size});
  final String? size;
}
