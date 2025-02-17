import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Res/app_url.dart';

class RegisterRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> registerUserapi(dynamic data) async {
    print(data.toString());
    try {
      dynamic response = await _apiServices.getPostWithoutTokenApiResponse(
          AppUrl.userRegisterUrl , data);
      return response;
    } catch (e) {
      throw e;
    }
  }

}
