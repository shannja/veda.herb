import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // ...

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // Automatically switches between #FAFAFA and #121212
      backgroundColor: theme.colorScheme.surface, 
      body: Center(
        child: Image.asset(
          'assets/images/logo/logo.png',
          width: 285,
        ),
      ),
    );
  }
}