import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:meta/meta.dart';

part 'types_state.dart';

class TypesCubit extends Cubit<TypesState> {
  TypesCubit() : super(TypesInitial()) {
    FirebaseFirestore.instance
        .collection('steps')
        .doc("type")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
        emit(TypesLoaded(
            question: snapshot.data()?["question"],
            questionAverage: snapshot.data()?["question_average"],
            placeholder: snapshot.data()?["placeholder"],
            types: (snapshot.data()?["items"] as List)
                .map((type) => {
                      DataKey.id: type["name"] as String,
                      DataKey.value: type["name"] as String
                    })
                .toList()));
      }
    });
  }
}
