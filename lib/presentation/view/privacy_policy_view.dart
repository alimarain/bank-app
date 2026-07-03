import 'package:flutter/material.dart';
import 'package:my_app/core/theme/app_colors.dart';
import 'package:my_app/presentation/view_model/privacy_policy_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrivacyPolicyViewModel>.reactive(
      viewModelBuilder: () => PrivacyPolicyViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 20,
              ),
              onPressed: viewModel.goBack,
            ),
            centerTitle: true,
            title: const Text(
              'Privacy Policy',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  const Text(
                    "STEP 2 OF 4",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  LinearProgressIndicator(
                    value: 0.50,
                    minHeight: 4,
                    backgroundColor: Colors.grey.shade300,
                    color: const Color(0xff00C853),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Privacy Policy",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        viewModel.privacyText,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          height: 1.7,
                        ),
                      ),
                    ),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: viewModel.isAccepted,
                        activeColor: AppColors.primary,
                        onChanged: viewModel.togglePrivacy,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "I agree to the Terms & Conditions and the Privacy Policy",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: viewModel.canContinue
                          ? viewModel.acceptPrivacyPolicy
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: const Color(0xffE6D8EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: viewModel.isBusy
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "NEXT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
