import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // =========================
  // Headings
  // =========================

  static TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryDark,
    letterSpacing: -1,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: -.5,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  // =========================
  // Body
  // =========================

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textLight,
  );

  // =========================
  // Labels
  // =========================

  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: AppColors.hint,
    letterSpacing: 1.2,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: AppColors.hint,
  );

  // =========================
  // Buttons
  // =========================

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    letterSpacing: .8,
  );

  // =========================
  // Text Fields
  // =========================

  static const TextStyle input = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle hint = TextStyle(fontSize: 16, color: Colors.black26);

  // =========================
  // OTP
  // =========================

  static TextStyle otp = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryDark,
  );

  // =========================
  // Links
  // =========================

  static TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );
}
