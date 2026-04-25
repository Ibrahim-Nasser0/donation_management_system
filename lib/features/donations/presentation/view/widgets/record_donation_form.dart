import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/widgets/labeled_field.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/category_chips_field.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/donor_autocomplete_field.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/record_donation_cubit/record_donation_cubit.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/record_donation_cubit/record_donation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RecordDonationForm extends StatefulWidget {
  final VoidCallback? onConfirmPressed;
  const RecordDonationForm({super.key, this.onConfirmPressed});

  @override
  State<RecordDonationForm> createState() => _RecordDonationFormState();
}

class _RecordDonationFormState extends State<RecordDonationForm> {
  final _amountCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void dispose() {
    _amountCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RecordDonationCubit>()..initForm(),
      child: BlocConsumer<RecordDonationCubit, RecordDonationState>(
        listener: _onStateChange,
        builder: (context, state) => Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Record Donation',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              Gap(20.h),
              DonorAutocompleteField(donors: state.donors),
              Gap(16.h),
              LabeledField(
                label: 'Amount',
                child: TextField(
                  controller: _amountCtrl,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 16.sp, color: AppColors.textPrimary),
                  decoration: _dec('Enter amount', Icons.attach_money),
                ),
              ),
              Gap(16.h),
              LabeledField(
                label: 'Description',
                child: TextField(
                  controller: _descCtrl,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
                  decoration: _dec('e.g. Monthly Contribution', Icons.description),
                ),
              ),
              Gap(16.h),
              CategoryChipsField(
                categories: state.categories,
                selectedCategory: state.selectedCategory,
                isLoading: state.status == RecordDonationStatus.loading,
              ),
              Gap(24.h),
              _SubmitButton(
                isSubmitting: state.isSubmitting,
                onPressed: () => context.read<RecordDonationCubit>().submitDonation(
                      amount: double.tryParse(_amountCtrl.text) ?? 0,
                      description: _descCtrl.text,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onStateChange(BuildContext context, RecordDonationState state) {
    if (state.status == RecordDonationStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donation recorded successfully!'), backgroundColor: Colors.green),
      );
      _amountCtrl.clear();
      _descCtrl.clear();
      context.read<RecordDonationCubit>().initForm();
      widget.onConfirmPressed?.call();
    } else if (state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage!), backgroundColor: Colors.red),
      );
      context.read<RecordDonationCubit>().resetStatus();
    }
  }

  InputDecoration _dec(String hint, IconData icon) => InputDecoration(
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

class _SubmitButton extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onPressed;
  const _SubmitButton({required this.isSubmitting, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: isSubmitting ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 2,
        ),
        child: isSubmitting
            ? const SizedBox(
                height: 20, width: 20,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : Text('Confirm Donation', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
