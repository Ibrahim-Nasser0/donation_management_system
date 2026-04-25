import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:donation_management_system/core/theme/colors.dart';

class CampaignGoalCard extends StatelessWidget {
  final String goalAmount;
  final String currentAmount;
  final String description;
  final double progress;

  const CampaignGoalCard({
    super.key,
    required this.goalAmount,
    required this.currentAmount,
    required this.description,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Campaign Goal',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white)),
          Gap(16.h),
          _AnimatedProgressBar(progress: progress),
          Gap(12.h),
          _AmountRow(currentAmount: currentAmount, goalAmount: goalAmount),
          Gap(16.h),
          Text(
            description,
            style: TextStyle(fontSize: 13.sp, color: Colors.white.withOpacity(0.7), height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _AnimatedProgressBar extends StatelessWidget {
  final double progress;
  const _AnimatedProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: progress),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      builder: (_, value, _) => ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.white.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 10.h,
        ),
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  final String currentAmount;
  final String goalAmount;
  const _AmountRow({required this.currentAmount, required this.goalAmount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _AmountLabel(label: 'Current', value: currentAmount, crossAxis: CrossAxisAlignment.start),
        _AmountLabel(label: 'Goal', value: goalAmount, crossAxis: CrossAxisAlignment.end),
      ],
    );
  }
}

class _AmountLabel extends StatelessWidget {
  final String label;
  final String value;
  final CrossAxisAlignment crossAxis;
  const _AmountLabel({required this.label, required this.value, required this.crossAxis});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxis,
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.white.withOpacity(0.7))),
        Text(value, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }
}
