import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:vedaherb/features/onboarding/loading.dart';
import 'package:vedaherb/features/onboarding/tutorial.dart';
import 'package:vedaherb/features/dashboard/dashboard.dart';

/// Helper to wrap screens in a consistent fade-in transition.
CustomTransitionPage _fadePage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  int durationMs = 800,
}) {
  return CustomTransitionPage(
    key: state.pageKey, 
    child: child,
    transitionsBuilder: (context, anim, secondaryAnim, child) {
      return FadeTransition(
        opacity: CurvedAnimation( 
          parent: anim,
          curve: Curves.easeInOut,
        ),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: durationMs),
  );
}

/// Global provider for application routing logic.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/loading',
    routes: [
      GoRoute(
        path: '/loading',
        pageBuilder: (context, state) => _fadePage(
          context: context,
          state: state,
          child: const LoadingScreen(),
        ),
      ),
      GoRoute(
        path: '/tutorial',
        pageBuilder: (context, state) => _fadePage(
          context: context,
          state: state,
          child: const TutorialScreen(),
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => _fadePage(
          context: context,
          state: state,
          child: const HomeScreen(),
          durationMs: 1000, // Slightly longer transition for the final entry.
        ),
      ),
    ],
  );
});