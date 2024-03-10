import 'package:costus/src/cubit/option_cubit.dart';
import 'package:costus/src/cubit/preliminary_cubit.dart';
import 'package:costus/src/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/step_view.dart';
import 'package:costus/src/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final colorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromRGBO(242, 41, 107, 1));
final colorSchemeDark = ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(242, 41, 107, 1),
    brightness: Brightness.dark);

OptionCubit _optionCubit = OptionCubit();
PreliminaryCubit _preliminaryCubit = PreliminaryCubit();

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp(
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
            switch (routeSettings.name) {
              case StepView.routeName:
                return MultiBlocProvider(providers: [
                  BlocProvider<OptionCubit>(create: (_) => _optionCubit),
                  BlocProvider<PreliminaryCubit>(
                      create: (_) => _preliminaryCubit),
                  BlocProvider<StepNavigationCubit>(
                      create: (_) => StepNavigationCubit(
                          optionCubit: _optionCubit,
                          preliminaryCubit: _preliminaryCubit))
                ], child: const StepView());
              default:
                return const LoginView();
            }
          },
        );
      },
    );
  }
}
