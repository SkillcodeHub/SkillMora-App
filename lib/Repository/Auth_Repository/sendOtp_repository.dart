import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Res/app_url.dart';

class SendOtpRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> sendOtpapi(dynamic data) async {
    print(data.toString());
    try {
      dynamic response = await _apiServices.getPostWithoutTokenApiResponse(
          AppUrl.sendOtpUrl , data);
      return response;
    } catch (e) {
      throw e;
    }
  }

}
