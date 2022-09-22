part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeSwitchLight extends ThemeEvent {
  final ThemeData lightTheme;

  const ThemeSwitchLight({required this.lightTheme});

  @override
  List<Object?> get props => [lightTheme];
}

class ThemeSwitchDark extends ThemeEvent {
  final ThemeData darkTheme;

  const ThemeSwitchDark({required this.darkTheme});

  @override
  List<Object?> get props => [darkTheme];
}
