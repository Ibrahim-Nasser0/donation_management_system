import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/add_case_dialog.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/add_case_cubit/add_case_cubit.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/cases_cubit/cases_cubit.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CaseActionsButtons extends StatelessWidget {
  final CaseEntity caseEntity;
  const CaseActionsButtons({super.key, required this.caseEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          size: 20.sp,
          color: AppColors.textSecondary,
        ),
        onSelected: (value) {
          switch (value) {
            case 'edit':
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: context.read<AddCaseCubit>()),
                      BlocProvider.value(value: context.read<CasesCubit>()),
                      BlocProvider.value(value: context.read<CategoriesBloc>()),
                    ],
                    child: AddCaseDialog(caseEntity: caseEntity),
                  );
                },
              );
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit_outlined, size: 18),
                Gap(8),
                Text('Edit'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
