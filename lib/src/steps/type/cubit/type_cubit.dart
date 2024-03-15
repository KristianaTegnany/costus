import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'type_state.dart';

class TypeCubit extends Cubit<TypeState> {
  TypeCubit() : super(TypeInitial());

  void onTypeChosen(String? type) {
    emit(TypeChosen(type: type));
  }
}
