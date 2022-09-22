import 'package:ella/core/theme/theme_data.dart';
import 'package:flutter/material.dart';

enum LightThemes { violetTheme }

enum DarkThemes { violetTheme }

Map<LightThemes, ThemeData> lightThemes = {
  LightThemes.violetTheme: violetLightTheme,
};

Map<DarkThemes, ThemeData> darkThemes = {
  DarkThemes.violetTheme: violetDarkTheme,
};
