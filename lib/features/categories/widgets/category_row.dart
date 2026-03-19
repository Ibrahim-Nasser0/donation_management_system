import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key, required IconData icon, required Color color, required String title, required String desc, required String cases, required String money});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Row(
        children: [
          _cell("Medical Aid", 200, bold: true),
          _cell("Critical support for patients", 260),
          _cell("1,245", 120),
          _cell("\$95,000", 150),

          const Spacer(),

          SizedBox(
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 12),
                Icon(Icons.delete, size: 18, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cell(String text, double width, {bool bold = false}) {
    return SizedBox(
      width: width.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Text(
          text,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}