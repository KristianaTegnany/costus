import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'material_cost_state.dart';

class MaterialCostCubit extends Cubit<MaterialCostState> {
  MaterialCostCubit() : super(MaterialCostInitial()){
    _subscription = FirebaseFirestore.instance
        .collection('steps')
        .doc("material_cost")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
          emit(MaterialCostLoaded(
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
