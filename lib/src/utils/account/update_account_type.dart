import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void updateAccountType(int value, void Function() callback) {
  callback();
  if (FirebaseAuth.instance.currentUser != null) {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"accountType": value});
    } catch (e) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "email": FirebaseAuth.instance.currentUser!.email,
        "accountType": value
      });
    }
  }
}
