import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'labor_hour_state.dart';

class LaborHourCubit extends Cubit<LaborHourState> {
  LaborHourCubit() : super(LaborHourInitial()){
    _subscription = FirebaseFirestore.instance
        .collection('steps')
        .doc("labor_hour")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
          emit(LaborHourLoaded(
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
