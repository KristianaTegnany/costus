import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'amount_state.dart';

class AmountCubit extends Cubit<AmountState> {
  AmountCubit() : super(AmountInitial()){
    _subscription = FirebaseFirestore.instance
        .collection('steps')
        .doc("preliminary_amount")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
          emit(AmountLoaded(
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
