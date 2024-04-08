part of 'types_cubit.dart';

@immutable
sealed class TypesState {
  const TypesState({this.question, this.placeholder, this.types});
  final String? question;
  final String? placeholder;
  final List<Map<DataKey, String>>? types;
}

final class TypesInitial extends TypesState {}

final class TypesLoaded extends TypesState {
  const TypesLoaded({super.types, super.placeholder, super.question});
}
