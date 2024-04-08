import 'package:costus/src/signup/signup_view.dart';
import 'package:costus/src/steps/city/cubit/cities_cubit.dart';
import 'package:costus/src/steps/competition/cubit/competitions_cubit.dart';
import 'package:costus/src/steps/country/cubit/countries_cubit.dart';
import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/part/cubit/part_cubit.dart';
import 'package:costus/src/steps/preliminary/cubit/preliminary_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/size/cubit/sizes_cubit.dart';
import 'package:costus/src/steps/step_view.dart';
import 'package:costus/src/login/login_view.dart';
import 'package:costus/src/steps/type/cubit/types_cubit.dart';
import 'package:costus/src/welcome/welcome_view.dart';
import 'package:costus/src/widget/unanimated_page_route.dart';
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
  //late StreamSubscription<User?> _sub;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    /*_sub = FirebaseAuth.instance.userChanges().listen((event) {
      _navigatorKey.currentState?.pushReplacementNamed(
        event != null ? StepView.routeName : LoginView.routeName,
      );
    });*/
  }

  @override
  void dispose() {
    //_sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp(
      initialRoute:
          '/' /*FirebaseAuth.instance.currentUser == null
          ? LoginView.routeName
          : StepView.routeName*/
      ,
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
          appBarTheme: AppBarTheme(
              backgroundColor: colorScheme.background,
              surfaceTintColor: colorScheme.background,
              elevation: 2)),

      darkTheme: ThemeData.dark().copyWith(
        colorScheme: colorSchemeDark,
      ),
      themeMode: ThemeMode.system,
      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return UnanimatedPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            CitiesCubit citiesCubit = CitiesCubit();
            PartsCubit partsCubit = PartsCubit();
            ResultCubit resultCubit =
                ResultCubit(citiesCubit: citiesCubit, partsCubit: partsCubit);

            if (routeSettings.name == SignupView.routeName) {
              return const SignupView();
            } else if (routeSettings.name == StepView.routeName) {
              OptionCubit optionCubit = OptionCubit(
                  resultCubit: resultCubit,
                  citiesCubit: citiesCubit,
                  partsCubit: partsCubit);
              PreliminaryCubit preliminaryCubit = PreliminaryCubit();

              return MultiBlocProvider(providers: [
                BlocProvider(create: (_) => citiesCubit),
                BlocProvider(create: (_) => resultCubit),
                BlocProvider(create: (_) => optionCubit),
                BlocProvider(create: (_) => preliminaryCubit),
                BlocProvider(create: (_) => CountriesCubit()),
                BlocProvider(create: (_) => SizesCubit()),
                BlocProvider(create: (_) => partsCubit),
                BlocProvider(create: (_) => TypesCubit()),
                BlocProvider(create: (_) => CompetitionsCubit()),
                BlocProvider<StepNavigationCubit>(
                    create: (_) => StepNavigationCubit(
                        resultCubit: resultCubit,
                        optionCubit: optionCubit,
                        preliminaryCubit: preliminaryCubit))
              ], child: const StepView());
            } else if (routeSettings.name == LoginView.routeName) {
              return const LoginView();
            } else {
              return BlocProvider(
                create: (context) => resultCubit,
                child: const WelcomeView(),
              );
            }
          },
        );
      },
    );
  }
}
