import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:meta/meta.dart';

part 'competitions_state.dart';

class CompetitionsCubit extends Cubit<CompetitionsState> {
  CompetitionsCubit() : super(CompetitionsInitial()) {
    FirebaseFirestore.instance
        .collection('steps')
        .doc("competition")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
        emit(CompetitionsLoaded(
            question: snapshot.data()?["question"],
            placeholder: snapshot.data()?["placeholder"],
            competitions: (snapshot.data()?["items"] as List)
                .map((competition) => {
                      DataKey.id: competition["name"] as String,
                      DataKey.value: competition["name"] as String
                    })
                .toList()));
      }
    });
  }
}
