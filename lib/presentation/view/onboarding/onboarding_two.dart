import 'package:flutter/material.dart';
import 'package:my_app/core/theme/app_colors.dart';
import 'package:my_app/core/theme/app_radius.dart';
import 'package:my_app/core/theme/app_spacing.dart';
import 'package:my_app/core/theme/app_text_styles.dart';
import 'package:my_app/presentation/view_model/onboarding_two_viewmodel.dart';
import 'package:my_app/presentation/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingTwoViewModel>.reactive(
      viewModelBuilder: () => OnboardingTwoViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: Column(
            children: [
              _buildNavBar(viewModel),
              Expanded(
                child: SingleChildScrollView(
                  padding: AppSpacing.pageHorizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'With the all details, it will only take a few minutes to create an account',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.black,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 40),
                      _buildDescriptionCard(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: PrimaryButton(
                  text: 'NEXT',
                  onPressed: viewModel.handleNextStep,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar(OnboardingTwoViewModel viewModel) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.sm,
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.black,
          size: 22,
        ),
        onPressed: viewModel.handleBack,
      ),
    ),
  );

  Widget _buildDescriptionCard() => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(AppSpacing.xxl),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: AppRadius.xlRadius,
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.03),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create account',
          style: AppTextStyles.title.copyWith(color: AppColors.primaryDark),
        ),
        const SizedBox(height: 12),
        const Divider(color: AppColors.border, thickness: 1),
        const SizedBox(height: 16),
        _buildStepItem('1', 'Your IC & Contact Details'),
        _buildStepItem('2', 'Email & Mobile Verification'),
        _buildStepItem('3', 'Privacy Policy'),
        _buildStepItem('4', 'Create PIN', isLast: true),
      ],
    ),
  );

  Widget _buildStepItem(String number, String title, {bool isLast = false}) =>
      Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0.0 : 20.0),
        child: Row(
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black38, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(
                number,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.black54,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.black54,
              ),
            ),
          ],
        ),
      );
}
