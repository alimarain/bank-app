import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/core/theme/app_colors.dart';
import 'package:my_app/core/theme/app_radius.dart';
import 'package:my_app/core/theme/app_text_styles.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = '',
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLength,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  final String hintText;
  final String? labelText;

  final TextInputType keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  final int? maxLength;

  final bool obscureText;
  final bool enabled;
  final bool readOnly;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      style: AppTextStyles.input,
      decoration: InputDecoration(
        counterText: '',
        labelText: labelText,
        hintText: hintText,
        hintStyle: AppTextStyles.hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.border, width: 1.5),
        ),

        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),

        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),

        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
      ),
    );
  }
}
