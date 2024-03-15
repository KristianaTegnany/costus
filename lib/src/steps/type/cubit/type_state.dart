part of 'type_cubit.dart';

@immutable
sealed class TypeState {
  const TypeState();
}

final class TypeInitial extends TypeState {}

final class TypeChosen extends TypeState {
  const TypeChosen({required this.type});
  final String? type;
}
