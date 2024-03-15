import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:meta/meta.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit() : super(CitiesInitial());

  void onCountryChanged(String country) {
    FirebaseFirestore.instance
        .collection('steps')
        .doc("countries")
        .collection("items")
        .doc(country)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
        emit(CitiesLoaded(
            question: snapshot.data()?["question"],
            placeholder: snapshot.data()?["placeholder"],
            cities: (snapshot.data()?["cities"] as List)
                .map((city) => {
                      DataKey.id: city["name"] as String,
                      DataKey.value: city["name"] as String
                    })
                .toList()));
      }
    });
  }
}
