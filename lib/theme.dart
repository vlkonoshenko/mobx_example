import 'package:flutter/material.dart';

const _primary = Color(0xff1A5CFF);
const _secondaryLight = Color(0xffBFDBFE);

const _secondaryDark = Color(0xff1E293B);

class AppTheme {
  static ThemeData theme(bool isDark) {
    return ThemeData(
        colorScheme: isDark
            ? const ColorScheme.dark(
                primary: _primary,
                secondary: _secondaryDark,
                background: Color(0xff1E1E1E),
              )
            : const ColorScheme.light(
                primary: _primary,
                secondary: _secondaryLight,
                background: Color(0xffC4C4C4),
              ),
        inputDecorationTheme: const InputDecorationTheme(
          outlineBorder: BorderSide(color: _primary),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: _primary),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ));
  }
}
