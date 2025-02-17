import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Res/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginapi(dynamic data) async {
    print(data.toString());
    try {
      dynamic response = await _apiServices.getPostWithoutTokenApiResponse(
          AppUrl.loginUrl , data);
      return response;
    } catch (e) {
      throw e;
    }
  }

}
