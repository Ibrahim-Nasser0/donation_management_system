import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/shimmer_loading.dart';
import 'package:donation_management_system/core/widgets/stat_card.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_kpis_entity.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donation_stats_cubit.dart';
import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationsStatsRow extends StatelessWidget {
  const DonationsStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationStatsCubit, DonationStatsState>(
      builder: (context, state) {
        if (state is DonationStatsLoading) return const ShimmerStatsRow(count: 4, cardHeight: 110);
        if (state is DonationStatsError) return Center(child: Text(state.message));
        if (state is DonationStatsLoaded) return _StatsCards(kpis: state.kpis);
        return const SizedBox.shrink();
      },
    );
  }
}

class _StatsCards extends StatelessWidget {
  final DonationKpisEntity kpis;
  const _StatsCards({required this.kpis});

  @override
  Widget build(BuildContext context) {
    final cards = [
      (title: 'Monthly Total', value: kpis.monthlyTotal.toCompactCurrency(), icon: Icons.account_balance_wallet_outlined),
      (title: 'Transactions', value: kpis.transactionCount.toString(), icon: Icons.receipt_long_outlined),
      (title: 'Top Category', value: kpis.topCategory, icon: Icons.star_border_outlined),
      (title: 'Pending Amount', value: kpis.pendingAmount.toCompactCurrency(), icon: Icons.hourglass_empty_outlined),
    ];

    return Row(
      children: List.generate(cards.length, (i) {
        final card = cards[i];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < cards.length - 1 ? 16.w : 0),
            child: FadeInUp(
              delay: Duration(milliseconds: i * 100),
              duration: const Duration(milliseconds: 500),
              child: StatCard(
                title: card.title,
                value: card.value,
                percentageChange: 0,
                icon: card.icon,
              ),
            ),
          ),
        );
      }),
    );
  }
}
