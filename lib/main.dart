import 'package:costus/config/config.dart';
import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseConfig = FirebaseConfig();
  await Firebase.initializeApp(
      options: kIsWeb
          ? FirebaseOptions(
              apiKey: firebaseConfig.apiKey,
              appId: firebaseConfig.appId,
              messagingSenderId: firebaseConfig.messagingSenderId,
              projectId: firebaseConfig.projectId)
          : null);
  runApp(BlocProvider(create: (context) => ThemeCubit(), child: const MyApp()));
}
