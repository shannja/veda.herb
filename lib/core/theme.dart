import 'package:flutter/material.dart';

class VedaTheme {
  static const Color brandGreen = Color.fromRGBO(95, 162, 104, 1);
  static const Color lightBg = Color.fromRGBO(250, 250, 250, 1);
  static const Color darkBg = Color.fromRGBO(18, 18, 18, 1);
  
  // Accent colors
  static const Color dangerRed = Color.fromRGBO(226, 77, 77, 1);
  static const Color warningYellow = Color.fromRGBO(255, 193, 7, 1);

  // Font Family Names
  static const String titleFont = 'Onest';
  static const String bodyFont = 'Funnel_Display';

  /// Shared Text Theme to keep things consistent
  static TextTheme _buildTextTheme(TextTheme base, Color textColor) {
    return base.copyWith(
      // For Page Titles / App Bar Titles
      displayLarge: TextStyle(
        fontFamily: titleFont,
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: titleFont,
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: textColor,
      ),
      // For Descriptions / Subtitles
      bodyLarge: TextStyle(
        fontFamily: bodyFont,
        fontSize: 16,
        color: textColor.withValues(alpha: 0.8),
      ),
      bodyMedium: TextStyle(
        fontFamily: bodyFont,
        fontSize: 14,
        color: textColor.withValues(alpha: 0.7),
      ),
      // For Buttons
      labelLarge: TextStyle(
        fontFamily: bodyFont,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: brandGreen,
        brightness: Brightness.light,
        surface: lightBg,
      ),
      textTheme: _buildTextTheme(base.textTheme, Colors.black87),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: brandGreen,
        brightness: Brightness.dark,
        surface: darkBg,
      ),
      textTheme: _buildTextTheme(base.textTheme, Colors.white),
    );
  }
}