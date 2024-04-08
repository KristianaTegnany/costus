import 'package:costus/config/config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseConfig = FirebaseConfig();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: firebaseConfig.apiKey,
          appId: firebaseConfig.appId,
          messagingSenderId: firebaseConfig.messagingSenderId,
          projectId: firebaseConfig.projectId));
  runApp(const MyApp());
}
