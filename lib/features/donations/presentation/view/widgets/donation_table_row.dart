import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/core/widgets/status_badge.dart';
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
            _cell(donation.donorName, width: 200.w),
            _cell(
              '\$${donation.amount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
              width: 140.w,
            ),
            _cell(donation.categoryName, width: 140.w),
            _cell(DateFormat('MMM dd, yyyy').format(donation.date), width: 140.w),
            _cell(donation.supervisorName, width: 150.w),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [StatusBadge(status: donation.status)],
              ),
            ),
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
}
