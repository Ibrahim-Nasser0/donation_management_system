import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/add_new_case.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/case_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CasesView extends StatelessWidget {
  const CasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: ListView(
        children: [
          Text('Cases Management', style: AppTypography.h1),
          Gap(5.h),
          Row(
            children: [
              Text(
                'Manage your donor database, track contributions, and maintain relationships with\nindividuals and corporate partners.',
                style: AppTypography.bodyMedium,
              ),
              const Spacer(),
              const AddNewCase(),
            ],
          ),
          Gap(20.h),
          const CasesViewBody(),
        ],
      ),
    );
  }
}
