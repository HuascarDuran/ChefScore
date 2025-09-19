import 'package:flutter/material.dart';
import 'app_bottom_nav.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppScaffold({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: child),
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}