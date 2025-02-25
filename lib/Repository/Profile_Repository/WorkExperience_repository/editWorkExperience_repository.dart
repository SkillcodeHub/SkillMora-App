import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';
import '../../../Res/app_url.dart';

class EditWorkExperienceRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> editWorkExperienceApi(
      String ipAddress, String token, Map<String, String> data) async {
    print(ipAddress);
    print(token);
    print(data);

    try {
      var response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.editWorkExperienceUrl + "?ipAddress=" + ipAddress,
          data,
          token.toString());
      return response;
    } catch (e) {
      throw e;
    }
  }
}
