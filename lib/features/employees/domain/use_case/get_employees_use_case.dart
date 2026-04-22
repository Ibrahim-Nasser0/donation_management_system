import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:donation_management_system/features/employees/domain/repo/employees_repo.dart';

class GetEmployeesUseCase {
  final EmployeesRepo repository;

  GetEmployeesUseCase({required this.repository});

  Future<Either<Failure, List<EmployeeEntity>>> call() async {
    return await repository.getEmployees();
  }
}
