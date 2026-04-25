import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddEmployeeFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final String selectedRole;
  final bool isEditing;
  final ValueChanged<String> onRoleChanged;

  const AddEmployeeFormFields({
    super.key,
    required this.nameController,
    required this.usernameController,
    required this.passwordController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.selectedRole,
    required this.isEditing,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: LabeledField(
                label: "Full Name",
                child: CustomTextField(
                  hint: "Enter full name",
                  controller: nameController,
                ),
              ),
            ),
            Gap(20.w),
            Expanded(
              child: LabeledField(
                label: "Username",
                child: CustomTextField(
                  hint: "e.g. sameh.r",
                  controller: usernameController,
                ),
              ),
            ),
          ],
        ),
        Gap(20.h),
        Row(
          children: [
            Expanded(
              child: LabeledField(
                label: "Email",
                child: CustomTextField(
                  hint: "employee@example.com",
                  controller: emailController,
                ),
              ),
            ),
            Gap(20.w),
            Expanded(
              child: LabeledField(
                label: "Password",
                child: CustomTextField(
                  hint: isEditing ? "Leave blank to keep current" : "Enter password",
                  controller: passwordController,
                  obscureText: true,
                ),
              ),
            ),
          ],
        ),
        Gap(20.h),
        Row(
          children: [
            Expanded(
              child: LabeledField(
                label: "Phone Number",
                child: CustomTextField(
                  hint: "01066665555",
                  controller: phoneController,
                ),
              ),
            ),
            Gap(20.w),
            Expanded(
              child: LabeledField(
                label: "Role",
                child: _buildRoleDropdown(),
              ),
            ),
          ],
        ),
        Gap(20.h),
        LabeledField(
          label: "Address",
          child: CustomTextField(
            hint: "123 Street, City, State",
            controller: addressController,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRole,
          isExpanded: true,
          items: ["Supervisor", "Admin", "Staff", "Field Worker"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (val) => onRoleChanged(val!),
        ),
      ),
    );
  }
}
