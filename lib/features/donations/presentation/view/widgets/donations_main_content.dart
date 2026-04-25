import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/shimmer_loading.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donations_cubit.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donations_state.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/donations_filters_bar.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/donations_table.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/campaign_goal_card.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/record_donation_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DonationsMainContent extends StatefulWidget {
  const DonationsMainContent({super.key});

  @override
  State<DonationsMainContent> createState() => _DonationsMainContentState();
}

class _DonationsMainContentState extends State<DonationsMainContent> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: FadeInLeft(duration: const Duration(milliseconds: 500), child: _TableSection(searchController: _searchController))),
        Gap(24.w),
        Expanded(flex: 1, child: FadeInRight(duration: const Duration(milliseconds: 500), child: _Sidebar())),
      ],
    );
  }
}

class _TableSection extends StatelessWidget {
  final TextEditingController searchController;
  const _TableSection({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationsCubit, DonationsState>(
      builder: (context, state) {
        if (state is DonationsLoading) return const ShimmerTable(rowCount: 8);
        if (state is DonationsError) return Center(child: Text(state.message));
        if (state is DonationsLoaded) {
          return Column(
            children: [
              DonationsFiltersBar(searchController: searchController, state: state),
              Gap(24.h),
              DonationsTable(donations: state.currentPageDonations),
              Gap(16.h),
              Pagination(
                currentPage: state.currentPage,
                totalItems: state.totalCount,
                itemsPerPage: 10,
                onPreviousPressed: state.currentPage > 1
                    ? () => context.read<DonationsCubit>().changePage(state.currentPage - 1)
                    : null,
                onNextPressed: state.currentPage < state.totalPages
                    ? () => context.read<DonationsCubit>().changePage(state.currentPage + 1)
                    : null,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecordDonationForm(onConfirmPressed: () {}),
        Gap(20.h),
        const CampaignGoalCard(
          goalAmount: '\$100k',
          currentAmount: '\$45,200',
          description: 'Help us reach our goal to support more families in need.',
          progress: 0.452,
        ),
      ],
    );
  }
}
