import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/providers/theme_provider.dart';

class AppTheme {
  ThemeData getTheme() {
    final themeProvider = ThemeProvider();
    return ThemeData(
      colorSchemeSeed: const Color(0xFF22D8F0),
      appBarTheme: const AppBarTheme(centerTitle: true),
      brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
    );
  }
}
