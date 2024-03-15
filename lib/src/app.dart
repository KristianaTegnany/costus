import 'dart:async';

import 'package:costus/src/steps/city/cubit/cities_cubit.dart';
import 'package:costus/src/steps/city/cubit/city_cubit.dart';
import 'package:costus/src/steps/competition/cubit/competition_cubit.dart';
import 'package:costus/src/steps/competition/cubit/competitions_cubit.dart';
import 'package:costus/src/steps/country/cubit/countries_cubit.dart';
import 'package:costus/src/steps/country/cubit/country_cubit.dart';
import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/preliminary/cubit/preliminary_cubit.dart';
import 'package:costus/src/steps/size/cubit/size_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/size/cubit/sizes_cubit.dart';
import 'package:costus/src/steps/type/cubit/type_cubit.dart';
import 'package:costus/src/steps/step_view.dart';
import 'package:costus/src/login/login_view.dart';
import 'package:costus/src/steps/type/cubit/types_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final colorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromRGBO(242, 41, 107, 1));
final colorSchemeDark = ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(242, 41, 107, 1),
    brightness: Brightness.dark);

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> _sub;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _sub = FirebaseAuth.instance.userChanges().listen((event) {
      _navigatorKey.currentState?.pushReplacementNamed(
        event != null ? StepView.routeName : LoginView.routeName,
      );
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? LoginView.routeName
          : StepView.routeName,
      navigatorKey: _navigatorKey,
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',

      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: ThemeData().copyWith(
        colorScheme: colorScheme,
      ),

      darkTheme: ThemeData.dark().copyWith(
        colorScheme: colorSchemeDark,
      ),
      themeMode: ThemeMode.system,
      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            if (routeSettings.name == StepView.routeName) {
              OptionCubit optionCubit = OptionCubit();
              PreliminaryCubit preliminaryCubit = PreliminaryCubit();
              CityCubit cityCubit = CityCubit();
              CitiesCubit citiesCubit = CitiesCubit();
              CountryCubit countryCubit =
                  CountryCubit(cityCubit: cityCubit, citiesCubit: citiesCubit);

              return MultiBlocProvider(providers: [
                BlocProvider<OptionCubit>(create: (_) => optionCubit),
                BlocProvider<PreliminaryCubit>(create: (_) => preliminaryCubit),
                BlocProvider(create: (_) => countryCubit),
                BlocProvider(create: (_) => CountriesCubit()),
                BlocProvider(create: (_) => cityCubit),
                BlocProvider(create: (_) => citiesCubit),
                BlocProvider(create: (_) => SizesCubit()),
                BlocProvider(create: (_) => SizeCubit()),
                BlocProvider(create: (_) => TypesCubit()),
                BlocProvider(create: (_) => TypeCubit()),
                BlocProvider(create: (_) => CompetitionsCubit()),
                BlocProvider(create: (_) => CompetitionCubit()),
                BlocProvider<StepNavigationCubit>(
                    create: (_) => StepNavigationCubit(
                        optionCubit: optionCubit,
                        preliminaryCubit: preliminaryCubit))
              ], child: const StepView());
            } else {
              return const LoginView();
            }
          },
        );
      },
    );
  }
}
