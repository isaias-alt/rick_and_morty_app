import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/providers/theme_provider.dart';

class AppTheme {
  ThemeData getTheme({required ThemeProvider themeProvider}) {
    return ThemeData(
      colorSchemeSeed: const Color(0xFF22D8F0),
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Schwifty',
            fontWeight: FontWeight.w800,
            fontSize: 30,
            color: Color(0xFF22D8F0),
            shadows: [
              Shadow(
                  color: Color(0xFF8EFF4D), offset: Offset(0, 0), blurRadius: 5)
            ],
          )),
      brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
    );
  }
}
