import 'package:donation_management_system/core/routes/routes.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/core/widgets/custom_button.dart';
import 'package:donation_management_system/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 460.w,
          height: 750.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: BoxBorder.all(color: AppColors.border),
          ),
          padding: EdgeInsets.all(48.w),

          child: Column(
            children: [const LogoArea(), const HeaderCard(), const LoginForm()],
          ),
        ),
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(40.h),
        Text('Welcome Back!', style: AppTypography.h1),
        Gap(10.h),
        Text(
          'Please enter your credentials to access the',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
        ),
        Gap(5.h),
        Text(
          'donation system.',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }
}

class LogoArea extends StatelessWidget {
  const LogoArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/Donation Logo.png',
          width: 35.w,
          height: 35.h,
        ),
        Gap(5.w),
        Text('Donation MS', style: AppTypography.h2),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Gap(20.h),

        CustomTextField(
          label: 'Username or Email',
          hint: 'Enter your email',
          prefixIcon: Icon(
            Icons.person_outline,
            color: AppColors.textSecondary,
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        Gap(20.h),
        CustomTextField(
          label: 'Password',
          hint: 'Enter your password',
          prefixIcon: Icon(Icons.lock_outline, color: AppColors.textSecondary),
          obscureText: true,
          keyboardType: TextInputType.text,
        ),
        Gap(10.h),
        SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: () {},
            child: Text(
              textAlign: TextAlign.end,
              'Forgot your password?',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
        Gap(20.h),
        CustomButton(
          height: 70.h,
          borderRadius: 16.r,
          text: 'Sign In',
          isLoading: false,

          onPressed: () {
            context.go(Routes.dashboard);
          },
        ),
      ],
    );
  }
}
