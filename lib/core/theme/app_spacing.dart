import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // Base spacing scale
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;
  static const double massive = 48;
  static const double giant = 56;
  static const double jumbo = 64;

  // Common page padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 20,
  );

  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(
    horizontal: 24,
  );

  static EdgeInsets pageHorizontal = EdgeInsets.symmetric(horizontal: 28);

  static EdgeInsets cardPadding = AppSpacing.cardPadding;

  static EdgeInsets dialogPadding = AppSpacing.dialogPadding;

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 14,
  );

  static const EdgeInsets textFieldContentPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 14,
  );
}
