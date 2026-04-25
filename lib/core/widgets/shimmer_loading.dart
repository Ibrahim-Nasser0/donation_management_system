import 'package:donation_management_system/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

// ─── Base Shimmer wrapper ────────────────────────────────────────────────────

/// Wraps any child widget with the app's standard shimmer effect.
class AppShimmer extends StatelessWidget {
  final Widget child;

  const AppShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }
}

// ─── Shimmer building block ───────────────────────────────────────────────────

/// A white rounded-corner placeholder box used inside shimmer layouts.
class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }
}

// ─── Preset: KPI / Stat Cards Row ────────────────────────────────────────────

/// Shimmer placeholder for a row of [count] KPI/stat cards.
class ShimmerStatsRow extends StatelessWidget {
  final int count;
  final double cardHeight;

  const ShimmerStatsRow({
    super.key,
    this.count = 4,
    this.cardHeight = 120,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Row(
        children: List.generate(count, (i) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < count - 1 ? 16.w : 0),
              child: ShimmerBox(width: double.infinity, height: cardHeight.h, radius: 16),
            ),
          );
        }),
      ),
    );
  }
}

// ─── Preset: Table ───────────────────────────────────────────────────────────

/// Shimmer placeholder for a data table with [rowCount] rows.
class ShimmerTable extends StatelessWidget {
  final int rowCount;
  final double rowHeight;

  const ShimmerTable({
    super.key,
    this.rowCount = 6,
    this.rowHeight = 64,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            // Header
            Container(
              height: 52.h,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
            ),
            // Rows
            ...List.generate(rowCount, (_) => _ShimmerTableRow(height: rowHeight)),
          ],
        ),
      ),
    );
  }
}

class _ShimmerTableRow extends StatelessWidget {
  final double height;
  const _ShimmerTableRow({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          ShimmerBox(width: 160.w, height: 14.h, radius: 6),
          const Spacer(),
          ShimmerBox(width: 80.w, height: 14.h, radius: 6),
          const Spacer(),
          ShimmerBox(width: 80.w, height: 14.h, radius: 6),
          const Spacer(),
          ShimmerBox(width: 70.w, height: 24.h, radius: 12),
        ],
      ),
    );
  }
}

// ─── Preset: Single card / sidebar block ─────────────────────────────────────

/// Shimmer placeholder for a single full-width card (sidebar, detail panel, etc.)
class ShimmerCard extends StatelessWidget {
  final double height;
  final double? width;

  const ShimmerCard({
    super.key,
    this.height = 300,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ShimmerBox(
        width: width ?? double.infinity,
        height: height.h,
        radius: 16,
      ),
    );
  }
}
