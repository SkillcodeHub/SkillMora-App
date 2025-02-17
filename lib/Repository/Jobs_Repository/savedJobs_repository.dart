import '../../../Data/Network/NetworkApiService.dart';
import '../../Data/Network/BaseApiServices.dart';
import '../../Models/FilterJobs/filterJobList_model.dart';
import '../../Models/FilterJobs/savedJobList_model.dart';
import '../../Res/app_url.dart';

class GetSavedJobsListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<SavedJobsModel> fetchSavedJobsList(
      String ipAddress, String token) async {

    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.savedJobsListUrl + '?ipAddress=' + ipAddress.toString(),
          token.toString());
      return response = SavedJobsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
