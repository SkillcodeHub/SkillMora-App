import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Res/app_url.dart';

class AddReviewRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> addReviewApi(String ipAddress,String token, Map<String, String> data) async {
    print(ipAddress);
        print(token);
        print(data);

    try {
      var response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.addcompanyreviewsUrl +"?ipAddress="+ ipAddress, data,token.toString() );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
