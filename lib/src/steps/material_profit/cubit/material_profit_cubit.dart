import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'material_profit_state.dart';

class MaterialProfitCubit extends Cubit<MaterialProfitState> {
  MaterialProfitCubit() : super(MaterialProfitInitial()){
    _subscription = FirebaseFirestore.instance
        .collection('steps')
        .doc("material_profit")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
          emit(MaterialProfitLoaded(
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
