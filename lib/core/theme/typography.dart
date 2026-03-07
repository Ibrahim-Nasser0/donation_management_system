import 'package:donation_management_system/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextStyle base = GoogleFonts.manrope(color: AppColors.textPrimary);

  static TextStyle h1 = base.copyWith(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle h2 = base.copyWith(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.3,
    height: 1.3,

    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = base.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.25,
    color: AppColors.textLight,
  );

  static TextStyle bodySmall = base.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.4,
    color: AppColors.textLight,
  );

  static TextStyle button = base.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle caption = base.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    height: 1.6,
    color: AppColors.textLight,
  );
}
