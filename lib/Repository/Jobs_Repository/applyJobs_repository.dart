import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Res/app_url.dart';

class ApplyJobRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> applyJobApi(String ipAddress,String token, Map<String, String> data) async {
    print(ipAddress);
        print(token);
        print(data);

    try {
      var response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.applyjobsUrl +"?ipAddress="+ ipAddress, data,token.toString(), );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
