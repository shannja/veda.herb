import 'package:flutter/material.dart';
import 'package:vedaherb/core/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? VedaTheme.darkBg : VedaTheme.lightBg,
      
      // Expandable body placeholder for future home content.
      body: const SizedBox.expand(),

      /// Primary action button for herb identification/scanning.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement AI Scan or Herb addition logic.
          print("FAB Pressed");
        },
        backgroundColor: VedaTheme.brandGreen,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.camera_alt, size: 30),
      ),
    );
  }
}