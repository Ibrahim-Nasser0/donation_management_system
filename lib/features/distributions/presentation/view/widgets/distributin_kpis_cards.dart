import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';

class DistributionKPIsCards extends StatelessWidget {
  const DistributionKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        KPICard(
          title: 'Total Distributed',
          value: '42,500',
          logo: 'assets/icons/funds distributed.png',
          icon: Icons.attach_money_rounded,
        ),

        KPICard(
          title: 'Pending Approval',
          value: '12',
          logo: 'assets/icons/active cases.png',
          icon: Icons.pending_actions,
        ),

        KPICard(
          title: 'Total Donors',
          value: '1,200',
          logo: 'assets/icons/Donors.png',
          icon: Icons.people_outline_outlined,
        ),

        KPICard(
          title: 'Active Allocations',
          value: '15,000',
          logo: 'assets/icons/funds distributed.png',
          icon: Icons.attach_money_rounded,
        ),
      ],
    );
  }
}
