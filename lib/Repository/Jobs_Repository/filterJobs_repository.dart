import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Models/FilterJobs/filterJobList_model.dart';
import '../../Res/app_url.dart';

class FilterJobsRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<FilterJobsModel> fetchFilterJobsApi(
      String limit,
      String offset,
      String clientId,
      String ipAddress,
      
      Map<String, String> data,String token) async {
    print('clientId');
    print(limit);
    print(offset);

    print(clientId);
    print(ipAddress);
    print(token);
    print(data);
    print('clientId');
    try {
      dynamic response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.filterJobsListUrl +
              "?limit=" +
              limit.toString() +
              "&offset=" +
              offset.toString() +
              "&clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress,
          
          data,token.toString());
      return response = FilterJobsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
