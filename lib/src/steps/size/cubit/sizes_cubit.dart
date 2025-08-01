import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:meta/meta.dart';

part 'sizes_state.dart';

class SizesCubit extends Cubit<SizesState> {
  SizesCubit() : super(SizesInitial()) {
    _subscription = FirebaseFirestore.instance
        .collection('steps')
        .doc("size")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
        emit(SizesLoaded(
            question: snapshot.data()?["question"],
            questionEstimate: snapshot.data()?["question_estimate"],
            placeholder: snapshot.data()?["placeholder"],
            sample: snapshot.data()?["sample"],
            sampleEstimate: snapshot.data()?["sample_estimate"],
            sizes: (snapshot.data()?["items"] as List)
                .map((size) => {
                      DataKey.id: size["name"] as String,
                      DataKey.data: size["value"].toString(),
                      DataKey.value: size["name"] as String
                    })
                .toList()));
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
