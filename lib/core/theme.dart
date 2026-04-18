import 'package:flutter/material.dart';

/// Centralized theme configuration for VedaHerb.
///
/// This class defines the visual identity of the app, utilizing 
/// brand-specific colors that remain legible in both light and dark modes.
class VedaTheme {
  // Brand Color Constants
  static const Color brandGreen = Color(0xFF5FA268);
  static const Color lightBg = Color(0xFFFAFAFA);
  static const Color darkBg = Color(0xFF121212);

  /// Light Mode: Clean medical/herbal aesthetic.
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandGreen,
          brightness: Brightness.light,
          surface: lightBg,
        ),
      );

  /// Dark Mode: Battery-efficient and low-strain aesthetic.
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandGreen,
          brightness: Brightness.dark,
          surface: darkBg,
        ),
      );
}