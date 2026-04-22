import 'package:donation_management_system/features/employees/domain/entity/employee_kpis_entity.dart';

abstract class EmployeeStatsState {}

class EmployeeStatsInitial extends EmployeeStatsState {}

class EmployeeStatsLoading extends EmployeeStatsState {}

class EmployeeStatsLoaded extends EmployeeStatsState {
  final EmployeeKpisEntity kpis;

  EmployeeStatsLoaded({required this.kpis});
}

class EmployeeStatsError extends EmployeeStatsState {
  final String message;

  EmployeeStatsError({required this.message});
}
