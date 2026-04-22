import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/employees_table.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_cubit.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesViewBody extends StatefulWidget {
  const EmployeesViewBody({super.key});

  @override
  State<EmployeesViewBody> createState() => _EmployeesViewBodyState();
}

class _EmployeesViewBodyState extends State<EmployeesViewBody> {
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  static const int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    context.read<EmployeesCubit>().getEmployees();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeesCubit, EmployeesState>(
      builder: (context, state) {
        if (state is EmployeesLoading || state is EmployeesInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is EmployeesError) {
          return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
        }

        if (state is EmployeesLoaded) {
          final allEmployees = state.employees;
          
          // Apply Search
          final query = _searchController.text.toLowerCase();
          final searchedEmployees = allEmployees.where((emp) {
            return emp.name.toLowerCase().contains(query) ||
                   emp.email.toLowerCase().contains(query) ||
                   emp.username.toLowerCase().contains(query);
          }).toList();

          final totalItems = searchedEmployees.length;
          final totalPages = (totalItems / _itemsPerPage).ceil().clamp(1, 999);
          final startItem = (_currentPage - 1) * _itemsPerPage;
          final endItem = (_currentPage * _itemsPerPage).clamp(0, totalItems);

          final displayedEmployees = searchedEmployees.sublist(startItem, endItem);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) {
                          setState(() {
                            _currentPage = 1;
                          });
                        },
                        style: TextStyle(fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: 'Search employees...',
                          hintStyle: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textLight,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.textLight,
                          ),
                          filled: true,
                          fillColor: AppColors.surface,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(color: AppColors.primary),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(16.w),
                  Text(
                    'Role:',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: state.selectedRole,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textSecondary,
                          size: 22.sp,
                        ),
                        style: AppTypography.button.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        items: const [
                          DropdownMenuItem(value: 'All', child: Text('All')),
                          DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                          DropdownMenuItem(value: 'Supervisor', child: Text('Supervisor')),
                          DropdownMenuItem(value: 'Employee', child: Text('Employee')),
                        ],
                        onChanged: (v) {
                          if (v != null) {
                            context.read<EmployeesCubit>().filterByRole(v);
                            setState(() => _currentPage = 1);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Gap(16.h),
              EmployeesTable(employees: displayedEmployees),
              Gap(16.h),
              if (totalItems > 0) ...[
                Text(
                  'Showing ${startItem + 1} to $endItem of $totalItems employees',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(12.h),
                Pagination(
                  currentPage: _currentPage,
                  totalItems: totalItems,
                  itemsPerPage: _itemsPerPage,
                  onPreviousPressed: () {
                    if (_currentPage > 1) {
                      setState(() => _currentPage--);
                    }
                  },
                  onNextPressed: () {
                    if (_currentPage < totalPages) {
                      setState(() => _currentPage++);
                    }
                  },
                ),
              ] else
                const Center(child: Text("No employees found.")),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
