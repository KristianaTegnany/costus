import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:meta/meta.dart';

part 'part_state.dart';

class PartsCubit extends Cubit<PartsState> {
  PartsCubit() : super(PartsInitial());

  void onTypeChanged(String? type) {
    if (type != null) {
      FirebaseFirestore.instance
          .collection('steps')
          .doc("type")
          .snapshots()
          .listen((typesSnapshot) {
        typesSnapshot.reference
            .collection("items")
            .doc(type.split(':')[0])
            .snapshots()
            .listen((snapshot) {
          if (snapshot.data() != null) {
            emit(PartsLoaded(
                question: typesSnapshot.data()?["question_building"],
                placeholder: typesSnapshot.data()?["placeholder_building"],
                parts: (snapshot.data()?["buildings"] as List)
                    .map((building) => {
                          DataKey.id: building["name"] as String,
                          DataKey.data: (building["value"] as List).join(':'),
                          DataKey.value: building["name"] as String
                        })
                    .toList()));
          }
        });
      });
    }
  }
}
