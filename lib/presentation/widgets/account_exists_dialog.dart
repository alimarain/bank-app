import 'package:flutter/material.dart';
import 'package:my_app/core/theme/app_colors.dart';
import 'package:my_app/core/theme/app_radius.dart';

class AccountExistsDialog extends StatelessWidget {
  const AccountExistsDialog({
    super.key,
    required this.onRetry,
    required this.onLogin,
  });

  final VoidCallback onRetry;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: AppRadius.lgRadius),
      title: const Text(
        "Account Already Exists",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text(
        "There is an account registered with this IC Number.\n\nPlease login to continue.",
      ),
      actions: [
        TextButton(onPressed: onRetry, child: const Text("Retry")),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          onPressed: onLogin,
          child: const Text("Login", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
