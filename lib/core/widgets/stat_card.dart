import 'package:donation_management_system/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Generic KPI stat card — used across feature pages (Donations, Cases, etc.)
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final double percentageChange;
  final IconData icon;
  final Color? iconColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentageChange,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPositive = percentageChange >= 0;
    final Color badgeColor = isPositive ? AppColors.success : AppColors.error;
    final Color resolvedIconColor = iconColor ?? AppColors.primary;

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopRow(
            title: title,
            percentageChange: percentageChange,
            badgeColor: badgeColor,
            isPositive: isPositive,
          ),
          Gap(16.h),
          _BottomRow(
            icon: icon,
            iconColor: resolvedIconColor,
            value: value,
          ),
        ],
      ),
    );
  }
}

class _TopRow extends StatelessWidget {
  final String title;
  final double percentageChange;
  final Color badgeColor;
  final bool isPositive;

  const _TopRow({
    required this.title,
    required this.percentageChange,
    required this.badgeColor,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary.withOpacity(0.8),
              letterSpacing: 0.5,
            ),
          ),
        ),
        if (percentageChange != 0)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: badgeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 11.sp,
                  color: badgeColor,
                ),
                Gap(2.w),
                Text(
                  '${percentageChange.abs()}%',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: badgeColor,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _BottomRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;

  const _BottomRow({
    required this.icon,
    required this.iconColor,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, size: 24.sp, color: iconColor),
        ),
        Gap(12.w),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }
}
