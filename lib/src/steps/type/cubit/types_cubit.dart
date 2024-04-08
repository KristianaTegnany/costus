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
        .listen((typeSnapshot) {
      if (typeSnapshot.data() != null) {
        typeSnapshot.reference
            .collection("items")
            .snapshots()
            .listen((snapshot) {
          emit(TypesLoaded(
              question: typeSnapshot.data()?["question"],
              placeholder: typeSnapshot.data()?["placeholder"],
              types: snapshot.docs
                  .map((type) => {
                        DataKey.id: type.id,
                        DataKey.data: type["value"].toString(),
                        DataKey.value: type["name"] as String
                      })
                  .toList()));
        });
      }
    });
  }
}
