import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/core/theme/app_colors.dart';
import 'package:my_app/core/theme/app_radius.dart';
import 'package:my_app/core/theme/app_spacing.dart';
import 'package:my_app/core/theme/app_text_styles.dart';
import 'package:my_app/presentation/view_model/onboarding_three_viewmodel.dart';
import 'package:my_app/presentation/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingThreeViewModel>.reactive(
      viewModelBuilder: () => OnboardingThreeViewModel(),
      disposeViewModel:
          false, // Keeps the routing animation context alive on Chrome Web
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildAppBar(viewModel),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'STEP 1 OF 4',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(
                          4,
                          (index) =>
                              _buildProgressBarItem(isActive: index == 0),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxxl),
                      Text(
                        'Hello! Let’s get your\naccount set',
                        style: AppTextStyles.heading.copyWith(
                          color: const Color(0xFF333333),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxxl),

                      _buildField(
                        'CUSTOMER NAME',
                        TextField(
                          textCapitalization: TextCapitalization.words,
                          onChanged: viewModel.updateCustomerName,
                          decoration: _buildInputDecoration('Please enter'),
                        ),
                      ),
                      _buildField(
                        'IC NUMBER',
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: viewModel.updateIcNumber,
                          decoration: _buildInputDecoration('Please enter'),
                        ),
                      ),
                      _buildField(
                        'MOBILE NUMBER',
                        TextField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9+]'),
                            ),
                          ],
                          onChanged: viewModel.updateMobileNumber,
                          decoration: _buildInputDecoration(''),
                        ),
                      ),
                      _buildField(
                        'EMAIL ADDRESS',
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: viewModel.updateEmailAddress,
                          decoration: _buildInputDecoration('Please enter'),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: PrimaryButton(
                  text: 'NEXT',
                  isLoading: viewModel.isBusy,
                  onPressed: viewModel.isFormValid && !viewModel.isBusy
                      ? () => viewModel.submitRegistrationDetails(context)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(OnboardingThreeViewModel viewModel) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
            size: 20,
          ),
          onPressed: viewModel.handleBack,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 48.0),
            child: Text(
              'Create account',
              textAlign: TextAlign.center,
              style: AppTextStyles.title.copyWith(color: AppColors.black),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildProgressBarItem({required bool isActive}) => Expanded(
    child: Container(
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: isActive ? AppColors.success : const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );

  Widget _buildField(String label, Widget field) => Padding(
    padding: const EdgeInsets.only(bottom: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: 4),
        field,
      ],
    ),
  );

  InputDecoration _buildInputDecoration(String hint) => InputDecoration(
    hintText: hint,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 10),
    hintStyle: AppTextStyles.hint,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.border, width: 1.2),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary, width: 1.8),
    ),
  );
}
