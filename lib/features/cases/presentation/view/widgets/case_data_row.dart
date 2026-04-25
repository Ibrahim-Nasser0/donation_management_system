import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/case_actions_buttons.dart';


class CaseDataRow extends StatelessWidget {
  final CaseEntity caseEntity;

  const CaseDataRow({super.key, required this.caseEntity});

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
          // ID
          Expanded(
            flex: 1,
            child: Text(
              '#${caseEntity.id}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Description
          Expanded(
            flex: 3,
            child: Text(
              caseEntity.name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Amount -> CategoryName
          Expanded(
            flex: 1,
            child: Text(
              caseEntity.categoryName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),

          // Date
          Expanded(
            flex: 1,
            child: Text(
              '${caseEntity.registDate.day}/${caseEntity.registDate.month}/${caseEntity.registDate.year}',
              style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
            ),
          ),

          // Status
          Expanded(
            flex: 1,
            child: _buildStatusBadge(),
          ),

          // Actions
          CaseActionsButtons(caseEntity: caseEntity),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final Color color = (caseEntity.status == 'Open' 
        ? Colors.green 
        : caseEntity.status == 'In Progress' 
            ? Colors.orange 
            : Colors.grey);
            
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        caseEntity.status,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
