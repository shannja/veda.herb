import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vedaherb/core/theme.dart';
import 'package:vedaherb/features/onboarding/loading.dart';

void main() {
  runApp(
    const ProviderScope(
      child: VedaHerb(),
    ),
  );
}

/// The root widget of the VedaHerb application.
///
/// This class manages global settings and listens to the system 
/// to toggle between light and dark themes.
class VedaHerb extends StatelessWidget {
  const VedaHerb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VedaHerb',
      debugShowCheckedModeBanner: false,
      
      // Theme Integration
      theme: VedaTheme.lightTheme,
      darkTheme: VedaTheme.darkTheme,
      themeMode: ThemeMode.system, 

      home: const LoadingScreen(),
    );
  }
}