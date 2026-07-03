import 'package:flutter/material.dart';
import 'package:my_app/core/theme/app_colors.dart';
import 'package:my_app/core/theme/app_radius.dart';
import 'package:my_app/core/theme/app_spacing.dart';
import 'package:my_app/core/theme/app_text_styles.dart';
import 'package:my_app/presentation/view_model/create_mpin_viewmodel.dart';
import 'package:my_app/presentation/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

class CreateMpinView extends StatelessWidget {
  const CreateMpinView({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode pinFocusNode = FocusNode();

    return ViewModelBuilder<CreateMpinViewModel>.reactive(
      viewModelBuilder: () => CreateMpinViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
            onPressed: viewModel.goBack,
          ),
          title: Text(
            viewModel.isConfirming ? 'Confirm MPIN' : 'Create MPIN',
            style: AppTextStyles.title.copyWith(color: AppColors.black),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Stack(
              children: [
                // Invisible capture field mapping hardware keyboard events securely
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.0,
                    child: TextField(
                      focusNode: pinFocusNode,
                      controller: viewModel.pinController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      maxLength: 6,
                      autofocus: true,
                      onChanged: viewModel.updatePin,
                      decoration: const InputDecoration(counterText: ''),
                    ),
                  ),
                ),

                // Visual Layout Structure Engine
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      viewModel.isConfirming ? "STEP 4 OF 4" : "STEP 3 OF 4",
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: viewModel.isConfirming ? 1.0 : 0.75,
                      minHeight: 4,
                      color: AppColors.success,
                      backgroundColor: const Color(0xFFE0E0E0),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    Text(
                      viewModel.isConfirming
                          ? "Confirm your 6-digit MPIN"
                          : "Create your 6-digit MPIN",
                      style: AppTextStyles.heading,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      viewModel.isConfirming
                          ? "Re-enter the same MPIN to continue."
                          : "Your MPIN will be used for quick and secure login.",
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        if (!pinFocusNode.hasFocus) pinFocusNode.requestFocus();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          6,
                          (index) => _buildPinIndicatorItem(viewModel, index),
                        ),
                      ),
                    ),
                    const Spacer(),
                    PrimaryButton(
                      text: "NEXT",
                      isLoading: viewModel.isBusy,
                      onPressed: viewModel.canContinue
                          ? viewModel.submitMpin
                          : null,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinIndicatorItem(CreateMpinViewModel viewModel, int index) =>
      Container(
        width: 50,
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFBDBDBD)),
          borderRadius: AppRadius.mdRadius,
        ),
        alignment: Alignment.center,
        child: viewModel.enteredDigits[index]
            ? const Icon(Icons.circle, size: 14, color: AppColors.black)
            : const SizedBox.shrink(),
      );
}
