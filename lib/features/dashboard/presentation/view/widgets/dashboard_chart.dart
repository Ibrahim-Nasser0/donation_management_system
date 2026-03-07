import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';

class DashboardChart extends StatelessWidget {
  const DashboardChart({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        width: 800.w,
        height: 500.h,
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            _ChartHeader(),
            Gap(24.h),
            Expanded(child: _ChartViewSection()),
          ],
        ),
      ),
    );
  }
}

class _ChartHeader extends StatelessWidget {
  const _ChartHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Donation Trends', style: AppTypography.h2),
            Text(
              'Overview of your fundraising performance',
              style: AppTypography.bodyMedium.copyWith(color: Colors.grey[500]),
            ),
            Gap(12.h),
            Row(
              children: [
                Text(
                  '\$ 45,200',
                  style: AppTypography.h1.copyWith(fontSize: 28.sp),
                ),
                Gap(12.w),
                const _GrowthBadge(percentage: '12.5%'),
              ],
            ),
          ],
        ),
        const Spacer(),
        const _PeriodSelector(),
      ],
    );
  }
}

class _GrowthBadge extends StatelessWidget {
  final String percentage;
  const _GrowthBadge({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(Icons.arrow_upward, size: 14.sp, color: Colors.green[700]),
          Gap(4.w),
          Text(
            percentage,
            style: TextStyle(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _PeriodSelector extends StatelessWidget {
  const _PeriodSelector();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 240.w,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.border, // تأكد أن surface لون رمادي فاتح جداً F5F5F5
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelStyle: AppTypography.bodySmall.copyWith(
          fontWeight: FontWeight.bold,
        ),
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        tabs: const [
          Tab(text: "Monthly"),
          Tab(text: "Weekly"),
          Tab(text: "Daily"),
        ],
      ),
    );
  }
}

class _ChartViewSection extends StatelessWidget {
  const _ChartViewSection();

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        _BaseLineChart(data: monthData, type: ChartType.monthly),
        _BaseLineChart(data: weekData, type: ChartType.weekly),
        _BaseLineChart(data: dayData, type: ChartType.daily),
      ],
    );
  }
}

enum ChartType { monthly, weekly, daily }

class _BaseLineChart extends StatelessWidget {
  final List<FlSpot> data;
  final ChartType type;

  const _BaseLineChart({required this.data, required this.type});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      duration: const Duration(milliseconds: 400),
      LineChartData(
        minX: 1,
        maxX: 12,
        minY: 0,
        maxY: 10,
        clipData: const FlClipData.none(),
        gridData: _buildGridData(),
        titlesData: _buildTitlesData(),
        borderData: FlBorderData(show: false),
        lineTouchData: _buildTouchData(),
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: true,
            color: AppColors.primary,
            barWidth: 3.5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                    radius: 3,
                    color: Colors.white,
                    strokeWidth: 2,
                    strokeColor: AppColors.primary,
                  ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withOpacity(0.15),
                  AppColors.primary.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineTouchData _buildTouchData() => LineTouchData(
    touchTooltipData: LineTouchTooltipData(
      getTooltipColor: (spot) => AppColors.primary,
      getTooltipItems: (spots) => spots
          .map(
            (s) => LineTooltipItem(
              '\$${s.y}k',
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
          .toList(),
    ),
  );

  FlGridData _buildGridData() => FlGridData(
    show: true,
    drawVerticalLine: false,
    getDrawingHorizontalLine: (value) =>
        FlLine(color: AppColors.border.withOpacity(0.2), strokeWidth: 1),
  );

  FlTitlesData _buildTitlesData() => FlTitlesData(
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 45.w,
        getTitlesWidget: (val, meta) => Text(
          '${val.toInt()}k',
          style: TextStyle(color: Colors.grey, fontSize: 11.sp),
        ),
      ),
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 1, // لإظهار كل النقاط
        reservedSize: 30.h,
        getTitlesWidget: (val, meta) => Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            _getLabel(val),
            style: TextStyle(color: Colors.grey, fontSize: 11.sp),
          ),
        ),
      ),
    ),
  );

  String _getLabel(double value) {
    if (type == ChartType.monthly) {
      const labels = {
        1: 'Jan',
        2: 'Feb',
        3: 'Mar',
        4: 'Apr',
        5: 'May',
        6: 'Jun',
        7: 'Jul',
        8: 'Aug',
        9: 'Sep',
        10: 'Oct',
        11: 'Nov',
        12: 'Dec',
      };
      return labels[value.toInt()] ?? '';
    } else if (type == ChartType.weekly) {
      const labels = {
        1: 'Mon',
        2: 'Tue',
        3: 'Wed',
        4: 'Thu',
        5: 'Fri',
        6: 'Sat',
        7: 'Sun',
      };
      return labels[value.toInt()] ?? '';
    } else {
      return '${value.toInt()}:00'; // لليومي مثلاً 10:00
    }
  }
}

// Mock Data
const monthData = [
  FlSpot(1, 3),
  FlSpot(2, 4),
  FlSpot(3, 6),
  FlSpot(4, 5),
  FlSpot(5, 8),
  FlSpot(6, 7),
];
const weekData = [
  FlSpot(1, 2),
  FlSpot(2, 5),
  FlSpot(3, 3),
  FlSpot(4, 6),
  FlSpot(5, 4),
  FlSpot(6, 8),
  FlSpot(7, 7),
];
const dayData = [
  FlSpot(1, 4),
  FlSpot(2, 3),
  FlSpot(3, 5),
  FlSpot(4, 2),
  FlSpot(5, 4),
];
