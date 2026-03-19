import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class CategoriesTable extends StatelessWidget {
  const CategoriesTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 44.h,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search categories...",
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      filled: true,
                      fillColor: AppColors.scaffold,
                      prefixIcon: const Icon(Icons.search, size: 18),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              SizedBox(
                height: 44.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                  ),
                  onPressed: () {},
                  child: const Text("+ Add New Category",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                _headerCell("CATEGORY NAME", 220),
                _headerCell("DESCRIPTION", 300),
                _headerCell("TOTAL CASES", 120),
                _headerCell("TOTAL DONATIONS", 160),
                const Spacer(),
                _headerCell("ACTIONS", 100),
              ],
            ),
          ),

          _row(
            icon: Icons.medical_services,
            color: const Color(0xFFE0F2FE),
            title: "Medical Aid",
            desc:
                "Critical support for life-saving surgeries, medication supplies, and emergency clinical procedures globally.",
            cases: "1,242",
            money: "\$450,800",
          ),

          _row(
            icon: Icons.school,
            color: const Color(0xFFFEF3C7),
            title: "Education",
            desc:
                "Funding for primary schools, digital literacy programs, and scholarships.",
            cases: "894",
            money: "\$212,150",
          ),

          _row(
            icon: Icons.restaurant,
            color: const Color(0xFFD1FAE5),
            title: "Food Security",
            desc:
                "Community gardens, food banks, and monthly nutrition programs.",
            cases: "3,412",
            money: "\$185,400",
          ),

          _row(
            icon: Icons.home,
            color: const Color(0xFFEDE9FE),
            title: "Housing",
            desc:
                "Shelter construction and emergency housing for displaced families.",
            cases: "456",
            money: "\$1,024,900",
          ),

          SizedBox(height: 16.h),

          Row(
            children: [
              Text(
                "Showing 1 to 4 of 24 categories",
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),

              _pageButton("1", active: true),
              _pageButton("2"),
              _pageButton("3"),
              _pageButton("..."),
              _pageButton("6"),
            ],
          )
        ],
      ),
    );
  }

  Widget _headerCell(String text, double width) {
    return SizedBox(
      width: width.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Text(
          text,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _row({
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
    required String cases,
    required String money,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 220.w,
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(icon, size: 18),
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: 300.w,
            child: Text(
              desc,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),

          SizedBox(
            width: 120.w,
            child: Text(cases, style: AppTypography.bodyMedium),
          ),

          SizedBox(
            width: 160.w,
            child: Text(
              money,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const Spacer(),

          SizedBox(
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.edit, size: 18, color: Colors.blue),
                SizedBox(width: 12),
                Icon(Icons.delete, size: 18, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageButton(String text, {bool active = false}) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: active ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}