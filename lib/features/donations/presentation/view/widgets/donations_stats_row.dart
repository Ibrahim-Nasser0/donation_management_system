import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donation_stats_cubit.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DonationsStatsRow extends StatelessWidget {
  const DonationsStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationStatsCubit, DonationStatsState>(
      builder: (context, state) {
        if (state is DonationStatsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DonationStatsError) {
          return Center(child: Text(state.message));
        }
        if (state is DonationStatsLoaded) {
          final kpis = state.kpis;
          return Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Total Donations',
                  value: '\$${kpis.totalAmount.toStringAsFixed(0)}',
                  percentageChange: 0, // Trends not implemented in kpis endpoint yet
                  icon: Icons.attach_money,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: StatCard(
                  title: 'Completed',
                  value: kpis.completedCount.toString(),
                  percentageChange: 0,
                  icon: Icons.check_circle_outline,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: StatCard(
                  title: 'Pending',
                  value: kpis.pendingCount.toString(),
                  percentageChange: 0,
                  icon: Icons.pending_outlined,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: StatCard(
                  title: 'Avg. Amount',
                  value: '\$${kpis.avgAmount.toStringAsFixed(0)}',
                  percentageChange: 0,
                  icon: Icons.trending_up_outlined,
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
