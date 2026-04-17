import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DonationTableRow extends StatelessWidget {
  final Donation donation;
  const DonationTableRow({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72.h,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _cell('#${donation.id}', width: 80.w),
            _cell(donation.donorName, width: 220.w),
            _cell('\$${donation.amount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
                width: 140.w),
            _cell(donation.categoryName, width: 140.w),
            _cell(DateFormat('MMM dd, yyyy').format(donation.date),
                width: 140.w),
            _cell(donation.supervisorName, width: 160.w),
            Expanded(child: _statusCell(donation.status)),
          ],
        ),
      ),
    );
  }

  Widget _cell(String text, {double? width, TextStyle? style}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.bodyMedium.merge(style),
      ),
    );
  }

  Widget _statusCell(String status) {
    Color color;
    Color bgColor;

    switch (status.toLowerCase()) {
      case 'completed':
        color = const Color(0xFF10B981);
        bgColor = const Color(0xFFD1FAE5);
        break;
      case 'pending':
        color = const Color(0xFFF59E0B);
        bgColor = const Color(0xFFFEF3C7);
        break;
      case 'cancelled':
        color = const Color(0xFFEF4444);
        bgColor = const Color(0xFFFEE2E2);
        break;
      default:
        color = AppColors.textSecondary;
        bgColor = AppColors.divider;
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          status,
          style: AppTypography.bodySmall.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
