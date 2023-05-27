import 'package:flutter/material.dart';
import 'package:pokedex_app/src/features/app_navigation_bar/presentation/app_navigation_bar.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const AppNavigationBar(),
    );
  }
}
