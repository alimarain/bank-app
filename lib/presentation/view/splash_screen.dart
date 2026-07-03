import 'package:flutter/material.dart';
import 'package:my_app/core/constants/asset_paths.dart';
import 'package:my_app/presentation/view/onboarding/onboarding_one.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // 1. PASTE IT HERE: Inside the State class, right before the build method
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // Don't navigate if the widget is no longer in the widget tree
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingOne(),
        ), // Your next screen
      );
    });
  }

  // 2. Your UI code stays inside the build method as usual
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFFE67E22), Color(0xFF9B59B6)],
              ),
            ),
          ),

          // Centered Logo
          Center(
            child: Image.asset(
              AssetPaths.logo, // Don't forget to add your logo image here
              width: 140,
              height: 140,
            ),
          ),

          // Footer Copyright Text
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Text(
              'Copyright © 2024 Koperasi Tentera',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
