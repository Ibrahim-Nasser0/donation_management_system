import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/add_new_category.dart';
import 'package:flutter/material.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: PageHeader(
        title: 'Categories Management',
        subtitle: 'Manage and organize donation categories for efficient tracking and reporting.',
        filledButtonText: 'Add Category',
        onFilledPressed: () {
          showDialog(
            context: context,
            builder: (dialogContext) => const AddCategoryDialog(),
          );
        },
      ),
    );
  }
}
