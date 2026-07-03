import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/core/constants/app_constants.dart';
import 'package:my_app/core/constants/asset_paths.dart';
import 'package:my_app/core/theme/app_colors.dart';
import 'package:my_app/core/theme/app_radius.dart';
import 'package:my_app/core/theme/app_spacing.dart';
import 'package:my_app/core/theme/app_text_styles.dart';
import 'package:my_app/presentation/view/onboarding/onboarding_two.dart';
import 'package:my_app/presentation/view_model/onboarding_one_viewmodel.dart';
import 'package:my_app/presentation/widgets/primary_button.dart';
import 'package:my_app/presentation/widgets/primary_text_field.dart';
import 'package:stacked/stacked.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<OnboardingOneViewmodel>.reactive(
      viewModelBuilder: () => OnboardingOneViewmodel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07,
                    vertical: AppSpacing.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(viewModel),
                      SizedBox(height: size.height * 0.06),
                      Text('Welcome to', style: AppTextStyles.heading2),
                      Text('Koperasi Tentera', style: AppTextStyles.heading1),
                      const SizedBox(height: AppSpacing.xl),
                      Text('PHONE NUMBER', style: AppTextStyles.label),
                      const SizedBox(height: 4),
                      PrimaryTextField(
                        hintText: 'Please enter Phone number',
                        keyboardType: TextInputType.phone,
                        maxLength: 15,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                          LengthLimitingTextInputFormatter(
                            AppConstants.maxPhoneLength,
                          ),
                        ],
                        onChanged: viewModel.updateIcNumber,
                      ),
                      const SizedBox(height: AppSpacing.xxxl),
                      PrimaryButton(
                        text: 'LOGIN',
                        isLoading: viewModel.isBusy,
                        onPressed: viewModel.submitLogin,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _buildRegisterFooter(context),
                    ],
                  ),
                ),
              ),
              _buildPromoBanner(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(OnboardingOneViewmodel viewModel) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset(
        AssetPaths.logo,
        height: 42,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Text(
          "KOPERASI\nTENTERA",
          style: AppTextStyles.caption.copyWith(color: const Color(0xFF7B2CBF)),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            _buildLangBtn(
              "MY",
              viewModel.currentLanguage == "MY",
              () => viewModel.changeLanguage("MY"),
            ),
            const SizedBox(width: 4),
            _buildLangBtn(
              "EN",
              viewModel.currentLanguage == "EN",
              () => viewModel.changeLanguage("EN"),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildRegisterFooter(BuildContext context) => Center(
    child: RichText(
      text: TextSpan(
        text: 'New to Koperasi Tentera? ',
        style: AppTextStyles.bodySmall.copyWith(fontSize: 14),
        children: [
          TextSpan(
            text: 'Register now',
            style: AppTextStyles.link,
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OnboardingTwo()),
              ),
          ),
        ],
      ),
    ),
  );

  Widget _buildPromoBanner() => Padding(
    padding: const EdgeInsets.all(AppSpacing.lg),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: AppRadius.lgRadius,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.wb_sunny_outlined, color: AppColors.white),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Oh My Cashback is back!',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4A148C),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Stand a chance to win cash prize with our financing!',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  Widget _buildLangBtn(String label, bool active, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.transparent,
            borderRadius: AppRadius.xlRadius,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            style: AppTextStyles.button.copyWith(
              color: active ? AppColors.white : AppColors.black,
              fontSize: 13,
            ),
            child: Text(label),
          ),
        ),
      );
}
