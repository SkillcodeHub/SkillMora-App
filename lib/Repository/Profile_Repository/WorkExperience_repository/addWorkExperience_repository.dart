import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';
import '../../../Res/app_url.dart';

class AddWorkExperienceRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> addWorkExperienceApi(
      String ipAddress, String token, Map<String, String> data) async {
    print(ipAddress);
    print(token);
    print(data);

    try {
      var response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.addWorkExperienceUrl + "?ipAddress=" + ipAddress,
          data,
          token.toString());
      return response;
    } catch (e) {
      throw e;
    }
  }
}
