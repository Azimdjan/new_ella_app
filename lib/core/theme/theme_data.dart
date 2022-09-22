import 'package:flutter/material.dart';
import 'colors/app_colors.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  applyElevationOverlayColor: true,
  errorColor: ThemeColors.errorColor,
  disabledColor: ThemeColors.disabledColor,
  splashColor: ThemeColors.primaryColor.withOpacity(0.05),
  focusColor: ThemeColors.primaryColor,
  primaryColor: ThemeColors.primaryColor,
  visualDensity: VisualDensity.standard,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  fontFamily: 'SF-Pro-Display',
  dividerTheme: const DividerThemeData(
    thickness: 1,
  ),
);

final violetLightTheme = appTheme.copyWith(
  backgroundColor: LightThemeColors.backgroundColor,
  scaffoldBackgroundColor: LightThemeColors.backgroundColor,
  brightness: Brightness.light,
  dividerTheme: appTheme.dividerTheme.copyWith(
    color: LightThemeColors.dividerColor,
  ),
);
final violetDarkTheme = appTheme.copyWith(
  backgroundColor: DarkThemeColors.backgroundColor,
  scaffoldBackgroundColor: DarkThemeColors.backgroundColor,
  brightness: Brightness.dark,
  dividerTheme: appTheme.dividerTheme.copyWith(
    color: DarkThemeColors.dividerColor,
  ),
);