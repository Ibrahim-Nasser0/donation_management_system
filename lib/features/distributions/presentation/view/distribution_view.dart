import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/distributions/presentation/view/widgets/add_new_distribution.dart';
import 'package:donation_management_system/features/distributions/presentation/view/widgets/dist_table.dart';
import 'package:donation_management_system/features/distributions/presentation/view/widgets/distributin_kpis_cards.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';


class DistributionView extends StatelessWidget {
  const DistributionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: ListView(
          children: [
            Text('Distributions Management', style: AppTypography.h1),
            Gap(5.h),
            Row(
              children: [
                Text(
                  'Manage your donor database, track contributions, and maintain relationships with\nindividuals and corporate partners.',
                  style: AppTypography.bodyMedium,
                ),
                const Spacer(),
                const AddNewDistribution(),
              ],
            ),
            Gap(20.h),
            const DistributionKPIsCards(),
            Gap(20.h),
            const DistribtionViewBody(),
          ],
        ),
      ),
    );
  }
}

class DistribtionViewBody extends StatefulWidget {
  const DistribtionViewBody({super.key});

  @override
  State<DistribtionViewBody> createState() => _DistribtionViewBodyState();
}

class _DistribtionViewBodyState extends State<DistribtionViewBody> {
  String _selectedFilter = 'All';

  final TextEditingController _searchController = TextEditingController();

  int _currentPage = 1;

  final List<String> _filters = ["All", "Completed", "Pending", "Processing"];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              FilterChips(
                hintText: 'Search ...',
                filters: _filters,
                selectedFilter: _selectedFilter,
                onFilterSelected: (filter) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
                searchController: _searchController,
                onSearchChanged: (value) {},
                onSortPressed: () {},
              ),
              Gap(16.h),
              const DistributionTable(),
              Gap(16.h),
              Pagination(
                currentPage: _currentPage,
                totalItems: 45,
                itemsPerPage: 5,
                onPreviousPressed: () {
                  if (_currentPage > 1) {
                    setState(() {
                      _currentPage--;
                    });
                  }
                },
                onNextPressed: () {
                  if (_currentPage < 9) {
                    setState(() {
                      _currentPage++;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
