import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'percent_state.dart';

class PercentCubit extends Cubit<PercentState> {
  PercentCubit() : super(PercentInitial()){
    _subscription = FirebaseFirestore.instance
        .collection('steps')
        .doc("preliminary_percent")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
          emit(PercentLoaded(
            question: snapshot.data()?["question"],
            placeholder: snapshot.data()?["placeholder"],
            sample: snapshot.data()?["sample"],));
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
