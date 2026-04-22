import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:donation_management_system/features/employees/domain/use_case/get_employees_use_case.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  final GetEmployeesUseCase getEmployeesUseCase;
  
  List<EmployeeEntity> _allEmployees = [];
  String _currentRoleFilter = 'All';

  EmployeesCubit({required this.getEmployeesUseCase}) : super(EmployeesInitial());

  Future<void> getEmployees() async {
    emit(EmployeesLoading());
    final result = await getEmployeesUseCase();
    result.fold(
      (failure) => emit(EmployeesError(message: failure.message)),
      (employees) {
        _allEmployees = employees;
        _emitFilteredEmployees();
      },
    );
  }

  void filterByRole(String role) {
    _currentRoleFilter = role;
    if (_allEmployees.isNotEmpty) {
      _emitFilteredEmployees();
    }
  }

  void _emitFilteredEmployees() {
    List<EmployeeEntity> filtered = _allEmployees;
    if (_currentRoleFilter != 'All') {
      filtered = _allEmployees.where((emp) => emp.role == _currentRoleFilter).toList();
    }
    emit(EmployeesLoaded(employees: filtered, selectedRole: _currentRoleFilter));
  }
}
