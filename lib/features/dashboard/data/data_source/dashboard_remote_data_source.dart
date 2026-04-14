import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';

import '../../../../core/network/errors/exceptions.dart';
import '../model/dashboard_kpis_model.dart';
import '../model/donation_trends_model.dart';
import '../model/last_donation_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardKpisModel> getDashboardKpis();
  Future<DonationTrendsModel> getDonationTrends();
  Future<List<LastDonationModel>> getLastDonations();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiConsumer apiConsumer;

  DashboardRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<DashboardKpisModel> getDashboardKpis() async {
    final response = await apiConsumer.get(ServerStrings.dashboardKPIs);
    try {
      return DashboardKpisModel.fromJson(response);
    } catch (e) {
      throw ParseException(message: 'Failed to parse KPIs: ${e.toString()}');
    }
  }

  @override
  Future<DonationTrendsModel> getDonationTrends() async {
    final response = await apiConsumer.get(ServerStrings.donationTrends);
    try {
      return DonationTrendsModel.fromJson(response);
    } catch (e) {
      throw ParseException(message: 'Failed to parse Trends: ${e.toString()}');
    }
  }

  @override
  Future<List<LastDonationModel>> getLastDonations() async {
    final response = await apiConsumer.get(ServerStrings.lastDonations);
    try {
      return (response as List).map((e) => LastDonationModel.fromJson(e)).toList();
    } catch (e) {
      throw ParseException(message: 'Failed to parse Last Donations: ${e.toString()}');
    }
  }
}
