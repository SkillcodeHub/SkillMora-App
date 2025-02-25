
import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';
import '../../../Res/app_url.dart';

class EditOtherDetailsRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> editOtherDetailsApi(
      String ipAddress, String token, Map<String, String> data) async {
    print(ipAddress);
    print(token);
    print(data);

    try {
      var response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.editOtherDetailsUrl + "?ipAddress=" + ipAddress,
          data,
          token.toString());
      return response;
    } catch (e) {
      throw e;
    }
  }
}
