part of 'theme_cubit.dart';

enum CategTheme { primary, secondary, tertiary }

@immutable
sealed class ThemeState {
  const ThemeState(
      {this.theme = CategTheme.primary, this.primary, this.background});
  final CategTheme theme;
  final Color? primary;
  final Color? background;
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial()
      : super(
          background: background,
          primary: primary,
        );
}

final class ThemeChanged extends ThemeState {
  const ThemeChanged({required super.theme})
      : super(
          background: theme == CategTheme.tertiary
              ? backgroundTertiary
              : theme == CategTheme.secondary
                  ? backgroundSecondary
                  : background,
          primary: theme == CategTheme.tertiary
              ? tertiary
              : theme == CategTheme.secondary
                  ? secondary
                  : primary,
        );
}
