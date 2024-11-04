import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitial()) {
    _subscription = FirebaseFirestore.instance
        .collection('steps')
        .doc("preliminary_add")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
          emit(AddLoaded(
            questionAmount: snapshot.data()?["question_amount"],
            questionPercentage: snapshot.data()?["question_percentage"],
            title: snapshot.data()?["title"],));
      }
    });
  }

  StreamSubscription<DocumentSnapshot>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
