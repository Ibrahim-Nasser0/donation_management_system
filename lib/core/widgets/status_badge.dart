import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  _BadgeStyle get _style {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'active':
        return _BadgeStyle(AppColors.success, AppColors.success.withOpacity(0.1));
      case 'pending':
        return _BadgeStyle(AppColors.warning, AppColors.warning.withOpacity(0.1));
      case 'cancelled':
      case 'inactive':
        return _BadgeStyle(AppColors.error, AppColors.error.withOpacity(0.1));
      default:
        return _BadgeStyle(AppColors.textSecondary, AppColors.divider.withOpacity(0.5));
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _style;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: s.bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: s.color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(color: s.color, shape: BoxShape.circle),
          ),
          Gap(5.w),
          Text(
            status,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodySmall.copyWith(
              color: s.color,
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeStyle {
  final Color color;
  final Color bgColor;
  const _BadgeStyle(this.color, this.bgColor);
}
