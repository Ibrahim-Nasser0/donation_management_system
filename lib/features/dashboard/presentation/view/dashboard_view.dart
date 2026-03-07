import 'package:donation_management_system/core/routes/routes.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_chart.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/kpis_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          const KPIsCards(),
          Gap(32.h),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const DashboardChart(),
                      Gap(32.h),
                      const RecentActivity(),
                    ],
                  ),
                ),
                Gap(32.w),
                SizedBox(
                  width: 385.w,
                  child: ListView(children: [NewCases()]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewCases extends StatelessWidget {
  const NewCases({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 385.w,
      height: 640.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: BoxBorder.all(color: AppColors.border),
      ),
      child: const Center(child: Text('New Cases')),
    );
  }
}

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 385.w,
      height: 400.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: BoxBorder.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Text('Recent Activity', style: AppTypography.h2),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.go(Routes.donations);
                  },
                  child: Text(
                    'View All',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const RecentActivityHeader(),
          const RecentActivtyRow(),
          const RecentActivtyRow(),
          const RecentActivtyRow(),
          const RecentActivtyRow(),
          const RecentActivtyRow(),
        ],
      ),
    );
  }
}

class RecentActivityHeader extends StatelessWidget {
  const RecentActivityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      color: AppColors.divider,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            SizedBox(
              width: 190.w,
              child: Text(
                'Donor',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),

            SizedBox(
              width: 150.w,
              child: Text(
                'Amount',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),

            SizedBox(
              width: 150.w,
              child: Text(
                'Category',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(
              width: 150.w,
              child: Text(
                'Date',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(
              width: 120.w,
              child: Text(
                textAlign: TextAlign.end,
                'Status',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentActivtyRow extends StatelessWidget {
  const RecentActivtyRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          SizedBox(
            width: 190.w,
            child: Text(
              'Ibrahim Nasser',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),

          SizedBox(
            width: 150.w,
            child: Text(
              '30,000',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),

          SizedBox(
            width: 150.w,
            child: Text(
              'Money',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(
            width: 150.w,
            child: Text(
              '2025/10/10',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(
            width: 120.w,
            child: Text(
              textAlign: TextAlign.end,
              'Completed',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
