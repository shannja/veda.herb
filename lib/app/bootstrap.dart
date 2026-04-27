import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vedaherb/app/app.dart';

/// DEBUG ONLY: set true to clear prefs on every launch.
/// This flag is automatically disabled in release builds for safety.
const bool _clearPreferencesOnLaunch = false;

Future<void> bootstrapMain() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Only clear preferences in debug mode AND if the flag is set
  if (kDebugMode && _clearPreferencesOnLaunch) {
    debugPrint('Bootstrap: Clearing preferences (debug mode only)');
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  runApp(const ProviderScope(child: VedaHerbApp()));
}

