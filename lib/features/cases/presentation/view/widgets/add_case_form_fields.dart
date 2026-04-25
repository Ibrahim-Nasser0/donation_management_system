import 'package:donation_management_system/core/utils/validators.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddCaseFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController descriptionController;
  final String selectedStatus;
  final int? selectedCategoryId;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<int> onCategoryChanged;

  const AddCaseFormFields({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
    required this.addressController,
    required this.descriptionController,
    required this.selectedStatus,
    required this.selectedCategoryId,
    required this.onStatusChanged,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
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
                  validator: (val) => Validators.minLength(val, 3, fieldName: 'Full Name'),
                ),
              ),
            ),
            Gap(20.w),
            Expanded(
              child: LabeledField(
                label: "Phone Number",
                child: CustomTextField(
                  hint: "+20 120 000 0000",
                  controller: phoneController,
                  validator: Validators.phone,
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
                label: "Address",
                child: CustomTextField(
                  hint: "123 Street, City, State",
                  controller: addressController,
                  validator: (val) => Validators.minLength(val, 5, fieldName: 'Address'),
                ),
              ),
            ),
            Gap(20.w),
            Expanded(
              child: LabeledField(
                label: "Status",
                child: _buildStatusDropdown(),
              ),
            ),
          ],
        ),
        Gap(20.h),
        LabeledField(
          label: "Category",
          child: _buildCategoryDropdown(),
        ),
        Gap(20.h),
        LabeledField(
          label: "Description",
          child: CustomTextField(
            hint: "Provide detailed information about the case...",
            controller: descriptionController,
            maxLines: 4,
            validator: (val) => Validators.minLength(val, 10, fieldName: 'Description'),
          ),
        ),
      ],
    ));
  }

  Widget _buildStatusDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedStatus,
          isExpanded: true,
          items: ["Approved", "Pending", "Rejected"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (val) => onStatusChanged(val!),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const LinearProgressIndicator();
        }
        if (state is CategoriesLoaded) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: selectedCategoryId,
                hint: const Text("Select Category"),
                isExpanded: true,
                items: state.masterCategories.map((cat) {
                  return DropdownMenuItem<int>(
                    value: cat.id,
                    child: Text(cat.type),
                  );
                }).toList(),
                onChanged: (val) => onCategoryChanged(val!),
              ),
            ),
          );
        }
        return const Text("Failed to load categories");
      },
    );
  }
}
