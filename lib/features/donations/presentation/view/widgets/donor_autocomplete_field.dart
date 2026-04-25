import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/widgets/labeled_field.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/record_donation_cubit/record_donation_cubit.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonorAutocompleteField extends StatelessWidget {
  final List<DonorEntity> donors;

  const DonorAutocompleteField({super.key, required this.donors});

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: 'Donor (Search by Name or ID)',
      child: Autocomplete<DonorEntity>(
        displayStringForOption: (o) => '${o.name} (ID: ${o.id})',
        optionsBuilder: (tv) {
          if (tv.text.isEmpty) return const Iterable<DonorEntity>.empty();
          final q = tv.text.toLowerCase();
          return donors.where(
            (d) => d.name.toLowerCase().contains(q) || d.id.toString().contains(q),
          );
        },
        onSelected: (donor) => context.read<RecordDonationCubit>().selectDonor(donor),
        fieldViewBuilder: (ctx, controller, focusNode, _) => TextField(
          controller: controller,
          focusNode: focusNode,
          style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
          decoration: _decoration('Search donor ...', Icons.person_search),
        ),
        optionsViewBuilder: (ctx, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 280.w,
              constraints: BoxConstraints(maxHeight: 250.h),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, _) => Divider(height: 1, color: AppColors.border),
                itemBuilder: (_, i) {
                  final donor = options.elementAt(i);
                  return ListTile(
                    title: Text(donor.name, style: TextStyle(fontSize: 14.sp)),
                    subtitle: Text('ID: ${donor.id}',
                        style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary)),
                    onTap: () => onSelected(donor),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(String hint, IconData icon) => InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, size: 20.sp, color: AppColors.textSecondary),
        hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary.withOpacity(0.6)),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
      );
}
