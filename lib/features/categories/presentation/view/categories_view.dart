import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/features/categories/widgets/categories_table.dart';
import 'package:donation_management_system/features/categories/widgets/kpi_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories Management Center",
              style: AppTypography.h1,
            ),

            SizedBox(height: 8.h),

            Text(
              "Organize, monitor and manage categories for effective distribution",
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            SizedBox(height: 24.h),

            const KPICards(),

            SizedBox(height: 24.h),

            const Expanded(child: CategoriesTable()),
          ],
        ),
      ),
    );
  }
}