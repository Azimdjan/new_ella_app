import 'package:flutter/material.dart';

class ThemeColors {
  static const primaryColor = Color(0xFF7165E5);
  static const errorColor = Color(0xFFF2271C);
  static const checkboxColor = Color(0xFF22B573);
  static const disabledColor = Color(0xFFEEF0F2);
  static const subtitle2Color = Color(0xFFA6A6A6);
}

class LightThemeColors extends ThemeColors {
  static const backgroundColor = Color(0xFFFFFFFF);
  static const scaffoldBackgroundColor = Color(0xFFF6F7F9);
  static const textColor = Color(0xFF000000);
  static const smallTextColor = Color(0xFF9AA6AC);
  static final dividerColor = const Color(0xFF000000).withOpacity(0.05);
  static const textFieldColor = Color(0xFFF3F3F3);
}

class DarkThemeColors extends ThemeColors {
  static const backgroundColor = Color(0xFF000000);
  static const scaffoldBackgroundColor = Color(0xFF090806);
  static const textColor = Color(0xFFFFFFFF);
  static const smallTextColor = Color(0xFF655953);
  static final dividerColor = const Color(0xFFFFFFFF).withOpacity(0.05);
}
