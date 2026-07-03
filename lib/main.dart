import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/app_locator.dart';
import 'package:my_app/core/theme/app_theme.dart';
import 'package:my_app/presentation/view/create_mpin_view.dart';
import 'package:my_app/presentation/view/privacy_policy_view.dart';
import 'package:my_app/presentation/view/splash_screen.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: StackedService.navigatorKey,

      theme: AppTheme.lightTheme,

      home: const SplashScreen(),
    );
  }
}
