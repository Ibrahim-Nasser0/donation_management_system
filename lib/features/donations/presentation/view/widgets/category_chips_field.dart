import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/widgets/labeled_field.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/record_donation_cubit/record_donation_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryChipsField extends StatelessWidget {
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;
  final bool isLoading;

  const CategoryChipsField({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: 'Category',
      child: isLoading
          ? const LinearProgressIndicator()
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories
                    .map((cat) => _ChipItem(
                          category: cat,
                          isSelected: selectedCategory?.id == cat.id,
                        ))
                    .toList(),
              ),
            ),
    );
  }
}

class _ChipItem extends StatelessWidget {
  final CategoryEntity category;
  final bool isSelected;

  const _ChipItem({required this.category, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: FilterChip(
        selected: isSelected,
        label: Text(category.type),
        onSelected: (_) => context.read<RecordDonationCubit>().selectCategory(category),
        selectedColor: AppColors.primary.withOpacity(0.2),
        checkmarkColor: AppColors.primary,
        backgroundColor: AppColors.surface,
        labelStyle: TextStyle(
          fontSize: 12.sp,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
        ),
      ),
    );
  }
}
