import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/utils/validators.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_event.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryDialog extends StatefulWidget {
  final CategoryEntity? category;
  const AddCategoryDialog({super.key, this.category});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _typeController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(text: widget.category?.type);
    _descriptionController = TextEditingController(text: widget.category?.description);
  }

  @override
  void dispose() {
    _typeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.category != null;

    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: _onStateChanged,
      builder: (context, state) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          title: _Title(isEdit: isEdit),
          content: _Fields(
            formKey: _formKey,
            typeController: _typeController,
            descriptionController: _descriptionController,
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
            ),
            _SubmitButton(
              isLoading: state is CategoryActionLoading,
              isEdit: isEdit,
              onPressed: () => _submit(context),
            ),
          ],
        );
      },
    );
  }

  void _onStateChanged(BuildContext context, CategoriesState state) {
    if (state is CategoryActionSuccess) {
      context.showSuccessSnackBar(state.message);
      Navigator.pop(context);
    } else if (state is CategoryActionError) {
      context.showErrorSnackBar(state.message);
    }
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final bloc = context.read<CategoriesBloc>();
      if (widget.category != null) {
        bloc.add(UpdateCategoryEvent(
          id: widget.category!.id,
          type: _typeController.text,
          description: _descriptionController.text,
        ));
      } else {
        bloc.add(AddCategoryEvent(
          type: _typeController.text,
          description: _descriptionController.text,
        ));
      }
    }
  }
}

class _Title extends StatelessWidget {
  final bool isEdit;
  const _Title({required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(isEdit ? 'Edit Category' : 'Add New Category', style: AppTypography.h2.copyWith(fontSize: 20.sp)),
        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.grey)),
      ],
    );
  }
}

class _Fields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController typeController;
  final TextEditingController descriptionController;

  const _Fields({required this.formKey, required this.typeController, required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.w,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LabeledField(
                label: 'Category Type',
                child: CustomTextField(
                  hint: "e.g. Health Support",
                  controller: typeController,
                  validator: (val) => Validators.minLength(val, 3, fieldName: 'Category Type'),
                ),
              ),
              Gap(20.h),
              LabeledField(
                label: 'Description',
                child: CustomTextField(
                  hint: "Enter category description",
                  controller: descriptionController,
                  maxLines: 3,
                  validator: (val) => Validators.minLength(val, 10, fieldName: 'Description'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool isLoading;
  final bool isEdit;
  final VoidCallback onPressed;

  const _SubmitButton({required this.isLoading, required this.isEdit, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(width: 20.sp, height: 20.sp, child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : Text(isEdit ? "Update Category" : "Add Category", style: const TextStyle(color: Colors.white)),
    );
  }
}

