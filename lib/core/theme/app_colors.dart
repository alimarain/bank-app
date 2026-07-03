import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // =========================
  // Brand
  // =========================

  static const Color primary = Color(0xFF7B2CBF); // Primary Brand Purple
  static const Color primaryDark = Color(0xFF4A148C); // Deeper Accent Purple
  static const Color primaryLight = Color(
    0xFFF3E5F5,
  ); // Light Tint Background Purple

  // =========================
  // Background
  // =========================

  static const Color background = Colors.white;
  static const Color surface = Colors.white;

  // =========================
  // Text
  // =========================

  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.black54;
  static const Color textLight = Colors.black45;
  static const Color hint = Colors.black38;

  // Compatibility aliases
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color black54 = Colors.black54;
  static const Color black45 = Colors.black45;
  static const Color black38 = Colors.black38;
  static const Color black26 = Colors.black26;
  static const Color grey = Colors.grey;

  // =========================
  // Borders
  // =========================

  static const Color border = Color(0xFFE0E0E0); // Standard light grey border
  static const Color borderLight = Color(0xFFE1BEE7);

  // =========================
  // Buttons
  // =========================

  static const Color button = primary;
  static const Color buttonDisabled = Color(0xFFE0D8E5);

  // =========================
  // Status
  // =========================

  static const Color success = Color(0xFF00C853);
  static const Color error = Colors.red;
  static const Color warning = Colors.orange;

  // =========================
  // Icons
  // =========================

  static const Color icon = Colors.black54;

  // =========================
  // Shadow
  // =========================

  static const Color shadow = Color(
    0x0A000000,
  ); // 4% opacity black for clean elevation shadows
}
