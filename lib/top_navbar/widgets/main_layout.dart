import 'package:donation_management_system/top_navbar/tob_navbar.dart';
import 'package:flutter/material.dart';


class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const TopNavbar(), body: child);
  }
}
