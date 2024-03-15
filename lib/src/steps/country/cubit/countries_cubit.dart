import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:meta/meta.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(CountriesInitial()) {
    FirebaseFirestore.instance
        .collection('steps')
        .doc("countries")
        .snapshots()
        .listen((countriesSnapshot) {
      if (countriesSnapshot.data() != null) {
        countriesSnapshot.reference
            .collection("items")
            .snapshots()
            .listen((snapshot) {
          emit(CountriesLoaded(
              question: countriesSnapshot.data()?["question"],
              placeholder: countriesSnapshot.data()?["placeholder"],
              countries: snapshot.docs
                  .map((country) => {
                        DataKey.id: country.id,
                        DataKey.value: country["name"] as String
                      })
                  .toList()));
        });
      }
    });
  }
}
