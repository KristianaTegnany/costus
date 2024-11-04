import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'preliminary_state.dart';

class PreliminaryCubit extends Cubit<PreliminaryState> {
  PreliminaryCubit() : super(PreliminaryInitial()) {
    _subscription = FirebaseFirestore.instance
        .collection('steps')
        .doc("preliminary")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
        emit(PreliminaryLoaded(
          questionYes: snapshot.data()?["question_yes"],
          questionNo: snapshot.data()?["question_no"],
          title: snapshot.data()?["title"],
        ));
      }
    });
  }

  StreamSubscription<DocumentSnapshot>? _subscription;

  void onPreliminaryChosen(bool choice) {
    emit(PreliminaryChosen(addingPreliminary: choice, state: state));
  }

  void onPreliminaryChoiceChosen(bool isAmount) {
    emit(PreliminaryChoiceChosen(isAmount: isAmount, state: state));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
