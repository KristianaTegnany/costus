import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:meta/meta.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit() : super(CitiesInitial());

  void onCountryChanged(String? country) {
    if (country != null) {
      _subscription = FirebaseFirestore.instance
          .collection('steps')
          .doc("countries")
          .snapshots()
          .listen((countriesSnapshot) {
        countriesSnapshot.reference
            .collection("items")
            .doc(country.split(':')[0])
            .snapshots()
            .listen((snapshot) {
          if (snapshot.data() != null) {
            emit(CitiesLoaded(
                question: countriesSnapshot.data()?["question_city"],
                placeholder: countriesSnapshot.data()?["placeholder_city"],
                sample: countriesSnapshot.data()?["sample_city"],
                cities: (snapshot.data()?["cities"] as List)
                    .map((city) => {
                          DataKey.id: city["name"] as String,
                          DataKey.data: city["value"].toString(),
                          DataKey.value: city["name"] as String
                        })
                    .toList()));
          }
        });
      });
    }
  }

  StreamSubscription<DocumentSnapshot>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
