import 'package:flutter/material.dart';
import 'package:my_app/core/constants/asset_paths.dart';
import 'package:my_app/core/theme/app_colors.dart';
import 'package:my_app/core/theme/app_radius.dart';
import 'package:my_app/core/theme/app_spacing.dart';
import 'package:my_app/core/theme/app_text_styles.dart';
import 'package:my_app/presentation/view_model/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      _buildFinanceCard(),
                      const SizedBox(height: 20),
                      _buildCashbackCard(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(viewModel),
      ),
    );
  }

  Widget _buildHeader() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hello, Mariam',
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryDark, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(4),
          child: Image.asset(
            AssetPaths.logo,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.grid_view_rounded,
              color: AppColors.primary,
              size: 20,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildFinanceCard() => Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.04),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1542037104857-ffbb0b9155fb?q=80&w=600&auto=format&fit=crop',
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 240,
                color: const Color(0xFFEEEEEE),
                child: const Icon(Icons.image, size: 48, color: AppColors.grey),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: Text(
                'PERSONAL FINANCE',
                style: AppTextStyles.label.copyWith(color: AppColors.black),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Build your home. Together.',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Realize your dream with our exciting financing with competitive rates.',
                style: AppTextStyles.body.copyWith(height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildCashbackCard() => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: AppRadius.xlRadius,
      border: Border.all(color: AppColors.borderLight),
    ),
    child: Row(
      children: [
        Container(
          width: 85,
          height: 75,
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: const Text(
            'Oh My\nCashback!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFFD700),
              fontWeight: FontWeight.bold,
              fontSize: 11,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Oh My Cashback is back!',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Stand a chance to win cash prize with our financing!',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildBottomNavBar(DashboardViewModel viewModel) => Container(
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
    ),
    child: BottomNavigationBar(
      currentIndex: viewModel.currentIndex,
      onTap: viewModel.setIndex,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.black26,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.waves_rounded),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.person_outline_rounded),
          ),
          label: 'Profile',
        ),
      ],
    ),
  );
}
