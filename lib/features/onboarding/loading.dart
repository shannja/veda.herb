import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _checkStatusAndNavigate();
  }

  /// Determines the initial destination based on user persistence.
  Future<void> _checkStatusAndNavigate() async {
    // Artificial delay to ensure the branding/logo is visible.
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    
    // Check if user has completed the onboarding flow; defaults to false.
    final bool hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

    // Ensure context is still valid before triggering GoRouter navigation.
    if (mounted) {
      hasSeenOnboarding ? context.go('/home') : context.go('/tutorial');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Image.asset('assets/images/logo/logo.png', width: 285),
      ),
    );
  }
}