import '../../../../core/network/errors/exceptions.dart';
import '../../../../core/network/api/api_consumer.dart';
import '../../../../core/network/api/api_endpoints.dart';
import '../model/dashboard_kpis_model.dart';
import '../model/donation_trends_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardKpisModel> getDashboardKpis();
  Future<DonationTrendsModel> getDonationTrends();
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
}
