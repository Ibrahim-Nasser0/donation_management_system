import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class KPICards extends StatelessWidget {
  const KPICards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _Card(
            title: "Total Active Categories",
            value: "24",
            icon: Icons.category,
            color: Color(0xFFE7F6EC),
            iconColor: AppColors.primary,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _Card(
            title: "Avg. Cases per Category",
            value: "152",
            icon: Icons.bar_chart,
            color: Color(0xFFEFF6FF),
            iconColor: Color(0xFF3B82F6),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _Card(
            title: "Highest Impact",
            value: "Medical Aid",
            icon: Icons.trending_up,
            color: Color(0xFFF5F3FF),
            iconColor: Color(0xFF8B5CF6),
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const _Card({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          /// 🟢 Icon Box
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),

          SizedBox(width: 12.w),

          /// 🟢 Texts
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                value,
                style: AppTypography.h2.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}