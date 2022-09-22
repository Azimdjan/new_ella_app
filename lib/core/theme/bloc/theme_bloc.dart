import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ella/core/theme/app_theme.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          ThemeInitial(
            lightTheme: lightThemes.values.first,
            darkTheme: darkThemes.values.first,
          ),
        ) {
    on<ThemeSwitchLight>(_switchToLightHandler);
    on<ThemeSwitchDark>(_switchToDarkHandler);
  }

  void _switchToLightHandler(ThemeSwitchLight event, Emitter<ThemeState> emit) {
    emit(
      ThemeLight(
        lightTheme: event.lightTheme,
      ),
    );
  }

  void _switchToDarkHandler(ThemeSwitchDark event, Emitter<ThemeState> emit) {
    emit(
      ThemeDark(
        darkTheme: event.darkTheme,
      ),
    );
  }
}
