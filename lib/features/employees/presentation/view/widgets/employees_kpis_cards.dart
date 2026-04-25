import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employee_stats_cubit/employee_stats_cubit.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employee_stats_cubit/employee_stats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesKPIsCards extends StatelessWidget {
  const EmployeesKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeStatsCubit, EmployeeStatsState>(
      builder: (context, state) {
        if (state is EmployeeStatsLoading || state is EmployeeStatsInitial) {
          return const ShimmerStatsRow(count: 4, cardHeight: 110);
        }

        if (state is EmployeeStatsError) {
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
        }

        if (state is EmployeeStatsLoaded) {
          final kpis = [
            (
              title: 'Total Employees',
              value: state.kpis.totalEmployees.toString(),
              icon: Icons.groups_outlined,
              color: const Color(0xFF6366F1)
            ),
            (
              title: 'Active Supervisors',
              value: state.kpis.activeSupervisors.toString(),
              icon: Icons.check_circle_outline_rounded,
              color: const Color(0xFF10B981)
            ),
            (
              title: 'Admins',
              value: state.kpis.adminCount.toString(),
              icon: Icons.admin_panel_settings_outlined,
              color: const Color(0xFFF59E0B)
            ),
            (
              title: 'Activity Rate',
              value: '${(state.kpis.monthlyActivityRate * 100).toStringAsFixed(1)}%',
              icon: Icons.trending_up_rounded,
              color: const Color(0xFF3B82F6)
            ),
          ];

          return Row(
            children: List.generate(kpis.length, (index) {
              final kpi = kpis[index];
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < kpis.length - 1 ? 16.w : 0),
                  child: FadeInUp(
                    delay: Duration(milliseconds: index * 100),
                    duration: const Duration(milliseconds: 500),
                    child: StatCard(
                      title: kpi.title,
                      value: kpi.value,
                      icon: kpi.icon,
                      iconColor: kpi.color,
                      percentageChange: 0,
                    ),
                  ),
                ),
              );
            }),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
