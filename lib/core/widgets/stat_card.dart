import 'package:donation_management_system/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Premium KPI stat card — used across feature pages
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final double percentageChange;
  final IconData icon;
  final Color? iconColor;
  final String? logo;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentageChange,
    required this.icon,
    this.iconColor,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPositive = percentageChange >= 0;
    final Color trendColor = isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final Color resolvedIconColor = iconColor ?? AppColors.primary;

    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: resolvedIconColor.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(logo != null ? 0 : 12.r),
                decoration: BoxDecoration(
                  color: logo != null ? Colors.transparent : resolvedIconColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: logo != null 
                  ? Image.asset(logo!, width: 44.w, height: 44.h, fit: BoxFit.contain)
                  : Icon(icon, size: 22.sp, color: resolvedIconColor),
              ),
              if (percentageChange != 0) _TrendBadge(isPositive: isPositive, value: percentageChange, color: trendColor),
            ],
          ),
          Gap(20.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E293B),
              letterSpacing: -1,
            ),
          ),
          Gap(4.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendBadge extends StatelessWidget {
  final bool isPositive;
  final double value;
  final Color color;

  const _TrendBadge({
    required this.isPositive,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            size: 14.sp,
            color: color,
          ),
          Gap(4.w),
          Text(
            '${value.abs()}%',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
