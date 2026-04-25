import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/employees/domain/entity/add_employee_params.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/add_employee_form_fields.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/add_employee_cubit/add_employee_cubit.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/add_employee_cubit/add_employee_state.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeDialog extends StatefulWidget {
  final EmployeeEntity? employee;
  const AddEmployeeDialog({super.key, this.employee});

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _emailController;
  late String selectedRole;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee?.name);
    _usernameController = TextEditingController(text: widget.employee?.username);
    _passwordController = TextEditingController();
    _phoneController = TextEditingController(text: widget.employee?.phone);
    _addressController = TextEditingController(text: widget.employee?.address);
    _emailController = TextEditingController(text: widget.employee?.email);
    selectedRole = widget.employee?.role ?? "Supervisor";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.employee != null;

    return BlocListener<AddEmployeeCubit, AddEmployeeState>(
      listener: (context, state) {
        if (state is AddEmployeeSuccess) {
          Navigator.pop(context);
          context.showSuccessSnackBar(isEditing ? 'Employee updated successfully!' : 'Employee added successfully!');
          context.read<EmployeesCubit>().getEmployees();
        } else if (state is AddEmployeeError) {
          context.showErrorSnackBar(state.message);
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        title: _buildTitle(context, isEditing),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: SingleChildScrollView(
            child: AddEmployeeFormFields(
              nameController: _nameController,
              usernameController: _usernameController,
              passwordController: _passwordController,
              emailController: _emailController,
              phoneController: _phoneController,
              addressController: _addressController,
              selectedRole: selectedRole,
              isEditing: isEditing,
              onRoleChanged: (val) => setState(() => selectedRole = val),
            ),
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        actions: _buildActions(context, isEditing),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool isEditing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(isEditing ? 'Edit Employee' : 'Add New Employee', style: AppTypography.h2.copyWith(fontSize: 20.sp)),
        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.grey)),
      ],
    );
  }

  List<Widget> _buildActions(BuildContext context, bool isEditing) {
    return [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
      ),
      BlocBuilder<AddEmployeeCubit, AddEmployeeState>(
        builder: (context, state) {
          final bool isLoading = state is AddEmployeeLoading;
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            onPressed: isLoading ? null : () => _submit(context, isEditing),
            child: isLoading
                ? SizedBox(width: 20.sp, height: 20.sp, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : Text(isEditing ? "Update Employee" : "Save Employee", style: const TextStyle(color: Colors.white)),
          );
        },
      ),
    ];
  }

  void _submit(BuildContext context, bool isEditing) {
    final params = AddEmployeeParams(
      name: _nameController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      role: selectedRole,
      phone: _phoneController.text,
      address: _addressController.text,
      email: _emailController.text,
    );

    if (isEditing) {
      context.read<AddEmployeeCubit>().updateEmployee(widget.employee!.id, params);
    } else {
      context.read<AddEmployeeCubit>().addEmployee(params);
    }
  }
}
