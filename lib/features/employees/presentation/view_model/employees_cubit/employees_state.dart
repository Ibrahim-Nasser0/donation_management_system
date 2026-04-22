import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';

abstract class EmployeesState {}

class EmployeesInitial extends EmployeesState {}

class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  final List<EmployeeEntity> employees;
  final String selectedRole;

  EmployeesLoaded({required this.employees, required this.selectedRole});
}

class EmployeesError extends EmployeesState {
  final String message;

  EmployeesError({required this.message});
}
