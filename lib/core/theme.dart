import 'package:flutter/material.dart';

class VedaTheme {
  static const Color brandGreen = Color(0xFF5FA268);
  static const Color lightBg = Color(0xFFFAFAFA);
  static const Color darkBg = Color(0xFF121212);

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