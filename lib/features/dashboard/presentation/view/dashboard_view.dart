import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_chart.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/kpis_cards.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/kpis_cubit/kpis_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/kpis_cubit/kpis_state.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/recent_activity_cubit/recent_activity_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/recent_activity_cubit/recent_activity_state.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/trends_cubit/trends_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/trends_cubit/trends_state.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/last_distributions_cubit/last_distributions_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/last_distributions_cubit/last_distributions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '../../../../core/routes/routes.dart';
import '../../domain/entity/last_donations_entity.dart';
import '../../domain/entity/last_distribution_entity.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<KpisCubit>()..getKpis()),
        BlocProvider(create: (context) => sl<TrendsCubit>()..getTrends()),
        BlocProvider(
          create: (context) => sl<RecentActivityCubit>()..getLastDonations(),
        ),
        BlocProvider(
          create: (context) =>
              sl<LastDistributionsCubit>()..getLastDistributions(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // KPIs Section
              const _KpisSection(),
              Gap(32.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // Trends Section
                        const _TrendsSection(),
                        Gap(32.h),
                        // Recent Activity Section
                        const _RecentActivitySection(),
                      ],
                    ),
                  ),
                  Gap(32.w),
                  // Last Distributions Section (Replaces New Cases)
                  const _LastDistributionsSection(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KpisSection extends StatelessWidget {
  const _KpisSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KpisCubit, KpisState>(
      builder: (context, state) {
        if (state is KpisLoaded) {
          return KPIsCards(kpis: state.kpis);
        } else if (state is KpisLoading) {
          return _buildShimmerKpis();
        } else if (state is KpisError) {
          return _ErrorWidget(
            message: state.message,
            onRetry: () => context.read<KpisCubit>().getKpis(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmerKpis() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          4,
          (index) => Container(
            width: 290.w,
            height: 160.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
    );
  }
}

class _TrendsSection extends StatelessWidget {
  const _TrendsSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendsCubit, TrendsState>(
      builder: (context, state) {
        if (state is TrendsLoaded) {
          return DashboardChart(trends: state.trends);
        } else if (state is TrendsLoading) {
          return _buildShimmerChart();
        } else if (state is TrendsError) {
          return _ErrorWidget(
            message: state.message,
            onRetry: () => context.read<TrendsCubit>().getTrends(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmerChart() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 800.w,
        height: 500.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}

class _RecentActivitySection extends StatelessWidget {
  const _RecentActivitySection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentActivityCubit, RecentActivityState>(
      builder: (context, state) {
        if (state is RecentActivityLoaded) {
          return RecentActivity(donations: state.donations);
        } else if (state is RecentActivityLoading) {
          return _buildShimmerActivity();
        } else if (state is RecentActivityError) {
          return _ErrorWidget(
            message: state.message,
            onRetry: () =>
                context.read<RecentActivityCubit>().getLastDonations(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmerActivity() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}

class _LastDistributionsSection extends StatelessWidget {
  const _LastDistributionsSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastDistributionsCubit, LastDistributionsState>(
      builder: (context, state) {
        if (state is LastDistributionsLoaded) {
          return LastDistributionsWidget(distributions: state.distributions);
        } else if (state is LastDistributionsLoading) {
          return _buildShimmerDistributions();
        } else if (state is LastDistributionsError) {
          return _ErrorWidget(
            message: state.message,
            onRetry: () =>
                context.read<LastDistributionsCubit>().getLastDistributions(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmerDistributions() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 385.w,
        height: 740.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(message, style: const TextStyle(color: Colors.red)),
          const Gap(8),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class LastDistributionsWidget extends StatelessWidget {
  final List<LastDistribution> distributions;
  const LastDistributionsWidget({super.key, required this.distributions});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 385.w,
      height: 620.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Text('Last Distributions', style: AppTypography.h2),
                const Spacer(),
                const Icon(Icons.more_vert, color: AppColors.textSecondary),
              ],
            ),
          ),
          const Divider(),
          if (distributions.isEmpty)
            const Expanded(child: Center(child: Text('No distributions found')))
          else
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(16.r),
                itemCount: distributions.length,
                separatorBuilder: (context, index) => Gap(16.h),
                itemBuilder: (context, index) {
                  final dist = distributions[index];
                  return Row(
                    children: [
                      Container(
                        width: 48.r,
                        height: 48.r,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.outbox_rounded,
                          color: AppColors.primary,
                          size: 24.r,
                        ),
                      ),
                      Gap(12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dist.caseName,
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gap(4.h),
                            Text(
                              DateFormat('MMM dd, yyyy').format(dist.date),
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(8.w),
                      Text(
                        '\$${dist.amount.toStringAsFixed(0)}',
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go(Routes.distributions);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary.withOpacity(0.05),
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: const Text('View Detailed Report'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecentActivity extends StatelessWidget {
  final List<LastDonation> donations;
  const RecentActivity({super.key, required this.donations});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Text('Recent Activity', style: AppTypography.h2),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.go(Routes.donations);
                  },
                  child: Text(
                    'View All',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const RecentActivityHeader(),
          if (donations.isEmpty)
            Padding(
              padding: EdgeInsets.all(32.r),
              child: const Text('No recent donations found'),
            )
          else
            ...donations.map((d) => RecentActivtyRow(donation: d)).toList(),
        ],
      ),
    );
  }
}

// ... rest of header and row classes remain same ...
class RecentActivityHeader extends StatelessWidget {
  const RecentActivityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      color: AppColors.divider.withOpacity(0.3),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            SizedBox(
              width: 190.w,
              child: Text(
                'Donor',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            SizedBox(
              width: 150.w,
              child: Text(
                'Amount',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            SizedBox(
              width: 150.w,
              child: Text(
                'Category',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            SizedBox(
              width: 150.w,
              child: Text(
                'Date',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.end,
                'Status',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentActivtyRow extends StatelessWidget {
  final LastDonation donation;
  const RecentActivtyRow({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          SizedBox(
            width: 190.w,
            child: Text(
              donation.donorName,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 150.w,
            child: Text(
              '\$ ${donation.amount.toStringAsFixed(0)}',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 150.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                donation.category,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 150.w,
            child: Text(
              DateFormat('yyyy-MM-dd').format(donation.date),
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Completed',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
