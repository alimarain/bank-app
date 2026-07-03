import 'package:flutter/material.dart';
import 'package:my_app/core/theme/app_colors.dart';
import 'package:my_app/core/theme/app_radius.dart';
import 'package:my_app/core/theme/app_spacing.dart';
import 'package:my_app/core/theme/app_text_styles.dart';
import 'package:my_app/presentation/view_model/otp_verification_viewmodel.dart';
import 'package:my_app/presentation/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  String _formatTimerDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpVerificationViewModel>.reactive(
      viewModelBuilder: () => OtpVerificationViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: BackButton(
            color: AppColors.black,
            onPressed: viewModel.navigateBack,
          ),
          actions: [
            TextButton(
              onPressed: viewModel.canResend && !viewModel.isBusy
                  ? viewModel.resendOtp
                  : null,
              child: Text(
                viewModel.canResend
                    ? "RESEND"
                    : "RESEND ${_formatTimerDuration(viewModel.remainingSeconds)}",
                style: AppTextStyles.button.copyWith(
                  color: viewModel.canResend
                      ? AppColors.primary
                      : AppColors.black26,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Icon(
                viewModel.isEmailVerification
                    ? Icons.email_outlined
                    : Icons.phone_android,
                size: 42,
                color: AppColors.icon,
              ),
              const SizedBox(height: 20),
              Text(
                'Enter 4-digit code sent to',
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.black),
              ),
              const SizedBox(height: 4),
              Text(viewModel.displayTarget, style: AppTextStyles.title),
              const SizedBox(height: AppSpacing.massive),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) => _buildOtpInputField(context, viewModel, index),
                ),
              ),
              const SizedBox(height: AppSpacing.massive),
              PrimaryButton(
                text: "VERIFY",
                isLoading: viewModel.isBusy,
                onPressed: viewModel.isOtpComplete && !viewModel.isBusy
                    ? () => viewModel.verifyOtpCode(context)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpInputField(
    BuildContext context,
    OtpVerificationViewModel viewModel,
    int index,
  ) => SizedBox(
    width: 60,
    child: TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      style: AppTextStyles.otp,
      decoration: const InputDecoration(
        counterText: "",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.border, width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2.5),
        ),
      ),
      onChanged: (value) {
        viewModel.updateCode(index, value);
        if (value.isNotEmpty && index < 3) {
          FocusScope.of(context).nextFocus();
        } else if (value.isEmpty && index > 0) {
          FocusScope.of(context).previousFocus();
        }
      },
    ),
  );
}
