part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class AppThemeSwitchLight extends AppEvent {
  final ThemeData lightTheme;

  const AppThemeSwitchLight({required this.lightTheme});

  @override
  List<Object?> get props => [lightTheme];
}

class AppThemeSwitchDark extends AppEvent {
  final ThemeData darkTheme;

  const AppThemeSwitchDark({required this.darkTheme});

  @override
  List<Object?> get props => [darkTheme];
}

class AppChangeLocale extends AppEvent {
  final String appLocale;

  const AppChangeLocale(this.appLocale);

  @override
  List<Object?> get props => [appLocale];
}
