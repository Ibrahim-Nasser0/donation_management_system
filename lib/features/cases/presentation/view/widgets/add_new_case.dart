import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/add_case_dialog.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/add_case_cubit/add_case_cubit.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/cases_cubit/cases_cubit.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCase extends StatelessWidget {
  const AddNewCase({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAddButton(
      text: "Add Case",
      onTap: () {
        final addCaseCubit = context.read<AddCaseCubit>();
        final casesCubit = context.read<CasesCubit>();
        final categoriesBloc = context.read<CategoriesBloc>();

        showDialog(
          context: context,
          builder: (dialogContext) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: addCaseCubit),
                BlocProvider.value(value: casesCubit),
                BlocProvider.value(value: categoriesBloc),
              ],
              child: const AddCaseDialog(),
            );
          },
        );
      },
    );
  }
}
