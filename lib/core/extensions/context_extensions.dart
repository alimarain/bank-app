import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Size get size => MediaQuery.of(this).size;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  void dismissKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
