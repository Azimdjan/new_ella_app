import 'package:ella/core/theme/bloc/theme_bloc.dart';
import 'package:ella/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  ThemeData? lightTheme;
  ThemeData? darkTheme;
  late ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeLight) {
          lightTheme = state.lightTheme;
          themeMode = ThemeMode.light;
        } else if (state is ThemeDark) {
          darkTheme = state.darkTheme;
          themeMode = ThemeMode.dark;
        } else if (state is ThemeInitial) {
          lightTheme = state.lightTheme;
          darkTheme = state.darkTheme;
          themeMode = ThemeMode.system;
        }
        return MaterialApp.router(
          title: 'Ella',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: router,
        );
      },
    );
  }
}