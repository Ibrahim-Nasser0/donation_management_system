import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/distributions/data/models/dist_table_model.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donor_data_row.dart';

class DistributionTable extends StatelessWidget {
  const DistributionTable({super.key});

  final List<TableHeader> headerCells = const [
    TableHeader(text: 'Case', flex: 2),
    TableHeader(text: 'Donation Source', flex: 1),
    TableHeader(text: 'Amount', flex: 1),
    TableHeader(text: 'Date', flex: 1),
    TableHeader(text: 'Empolyee', flex: 1),
    TableHeader(text: 'Status', flex: 1),
    TableHeader(text: 'Actions', flex: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomTable(
      headerCells: headerCells,
      dataRow: [
        DistributionTableModel(
          caseName: "أحمد محمد علي",
          donorName: "مؤسسة الخير",
          empolyeeName: "سارة محمود",
          amount: 1500.0,
          date: DateTime.now(),
          status: DistributionStatus.completed,
        ),
        DistributionTableModel(
          caseName: "فاطمة إبراهيم",
          donorName: "فاعل خير",
          empolyeeName: "خالد جابر",
          amount: 500.0,
          date: DateTime.now().subtract(const Duration(days: 1)),
          status: DistributionStatus.pending,
        ),
        DistributionTableModel(
          caseName: "مستشفى الأمل",
          donorName: "شركة توريدات",
          empolyeeName: "منى القحطاني",
          amount: 3000.0,
          date: DateTime.now().subtract(const Duration(days: 3)),
          status: DistributionStatus.processing,
        ),
        DistributionTableModel(
          caseName: "عائلة بورسلي",
          donorName: "صندوق الزكاة",
          empolyeeName: "عمر فاروق",
          amount: 200.0,
          date: DateTime.now().subtract(const Duration(days: 5)),
          status: DistributionStatus.draft,
        ),
        DistributionTableModel(
          caseName: "ياسر جلال",
          donorName: "فرد مستقل",
          empolyeeName: "ليلى حسن",
          amount: 1250.75,
          date: DateTime.now(),
          status: DistributionStatus.completed,
        ),
      ],
      itemBuilder: (item) => DistributionDataRow(distribution: item),
    );
  }
}

class DistributionDataRow extends StatelessWidget {
  final DistributionTableModel distribution;

  const DistributionDataRow({super.key, required this.distribution});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
      ),
      child: Row(
        children: [
          // case name with avatar
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primary.withOpacity(0.1),

                  child: Text(
                    distribution.donorName.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    distribution.caseName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Text(
              distribution.donorName,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
          ),

          //case amount
          Expanded(
            flex: 1,
            child: Text(
              distribution.amount.toString(),
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
          ),

          //case Contact info
          Expanded(
            flex: 1,
            child: Text(
              '${distribution.date.day}/${distribution.date.month}/${distribution.date.year}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Text(
              overflow: TextOverflow.fade,
              distribution.empolyeeName,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
          ),

          //case registration date
          Expanded(
            //Donor registration date
            flex: 1,
            child: Text(
              distribution.status.name,
              style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
            ),
          ),

          //Actions buttons
          ActionsButtons(),
        ],
      ),
    );
  }
}
