import 'package:donation_management_system/core/widgets/filter_chips.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_state.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donations_cubit.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationsFiltersBar extends StatelessWidget {
  final TextEditingController searchController;
  final DonationsLoaded state;

  const DonationsFiltersBar({
    super.key,
    required this.searchController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, catState) {
        final categories = ['All'];
        if (catState is CategoriesLoaded) {
          categories.addAll(catState.masterCategories.map((e) => e.type));
        }
        return FilterChips(
          hintText: 'Search donations ...',
          filters: categories,
          selectedFilter: state.selectedCategory ?? 'All',
          onFilterSelected: (f) => context.read<DonationsCubit>().filterDonations(category: f),
          searchController: searchController,
          onSearchChanged: (v) => context.read<DonationsCubit>().filterDonations(query: v),
          onSortPressed: () {},
        );
      },
    );
  }
}
