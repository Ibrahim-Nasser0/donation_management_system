import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DonationsTableHeaderActions extends StatelessWidget {
  const DonationsTableHeaderActions({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 400),
      child: PageHeader(
        title: 'Donations Tracking',
        subtitle: 'Monitor and manage all donations in one place',
       // filledButtonText: 'New Donation',
        onFilledPressed: () {},
      ),
    );
  }
}
