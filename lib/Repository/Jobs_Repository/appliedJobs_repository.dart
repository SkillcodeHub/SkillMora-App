import '../../../Data/Network/NetworkApiService.dart';
import '../../Data/Network/BaseApiServices.dart';
import '../../Models/FilterJobs/appliedJobList_model.dart';
import '../../Res/app_url.dart';

class GetAppliedJobsListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<AppliedJobsModel> fetchAppliedJobsList(
      String ipAddress, String token) async {
    print(
        'ipAddress   ipAddress   ipAddress   ipAddress   ipAddress   ipAddress   ipAddress   ');
    print(ipAddress);
    print(token);
    print(
        'ipAddress   ipAddress   ipAddress   ipAddress   ipAddress   ipAddress   ipAddress   ');

    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.appliedJobsListUrl + '?ipAddress=' + ipAddress.toString(),
          token.toString());
      return response = AppliedJobsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
