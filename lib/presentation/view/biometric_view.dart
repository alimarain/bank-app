import 'package:flutter/material.dart';
import 'package:my_app/core/theme/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/presentation/view_model/biometric_viewmodel.dart';

class BiometricView extends StatelessWidget {
  const BiometricView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BiometricViewModel>.reactive(
      viewModelBuilder: () => BiometricViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: viewModel.goBack,
            ),
            title: const Text(
              "Biometric",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 20),

                const Text(
                  "STEP 4 OF 4",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                LinearProgressIndicator(
                  value: 1,
                  minHeight: 4,
                  backgroundColor: Colors.grey.shade300,
                  color: const Color(0xff00C853),
                ),

                const SizedBox(height: 50),

                Icon(Icons.fingerprint, size: 130, color: AppColors.primary),

                const SizedBox(height: 30),

                const Text(
                  "Enable Biometric Login",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Use your fingerprint or Face ID for quick and secure login.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: viewModel.enableBiometric,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: viewModel.isBusy
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "ENABLE NOW",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 15),

                TextButton(
                  onPressed: viewModel.skip,
                  child: const Text(
                    "Maybe Later",
                    style: TextStyle(fontSize: 15),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
