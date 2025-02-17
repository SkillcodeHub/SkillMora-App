import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Res/app_url.dart';

class VerifyOtpRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> verifyOtpapi(dynamic data) async {
    print(data.toString());
    try {
      dynamic response = await _apiServices.getPostWithoutTokenApiResponse(
          AppUrl.verifyOtpUrl , data);
      return response;
    } catch (e) {
      throw e;
    }
  }

}
