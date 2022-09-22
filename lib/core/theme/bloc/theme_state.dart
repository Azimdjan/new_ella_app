part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const ThemeInitial({required this.lightTheme, required this.darkTheme});

  @override
  List<Object?> get props => [lightTheme, darkTheme];
}

class ThemeLight extends ThemeState {
  final ThemeData lightTheme;

  const ThemeLight({required this.lightTheme});

  @override
  List<Object?> get props => [lightTheme];
}

class ThemeDark extends ThemeState {
  final ThemeData darkTheme;

  const ThemeDark({required this.darkTheme});

  @override
  List<Object?> get props => [darkTheme];
}
