import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/employees/domain/entity/add_employee_params.dart';
import 'package:donation_management_system/features/employees/domain/repo/employees_repo.dart';

class AddEmployeeUseCase {
  final EmployeesRepo repository;

  AddEmployeeUseCase({required this.repository});

  Future<Either<Failure, void>> call(AddEmployeeParams params) async {
    return await repository.addEmployee(params);
  }
}
