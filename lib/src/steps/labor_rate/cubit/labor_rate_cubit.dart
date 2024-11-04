import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'labor_rate_state.dart';

class LaborRateCubit extends Cubit<LaborRateState> {
  LaborRateCubit() : super(LaborRateInitial()){
    _subscription = FirebaseFirestore.instance
        .collection('steps')
        .doc("labor_rate")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
          emit(LaborRateLoaded(
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
