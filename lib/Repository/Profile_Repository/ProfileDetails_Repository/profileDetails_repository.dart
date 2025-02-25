import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';
import '../../../Models/ProfileDetails_Model/profileDetails_model.dart';
import '../../../Res/app_url.dart';

class ProfileDetailsRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ProfileDetailsModel> fetchProfileDetails(
      String ipAddress,String email, String token) async {
print(ipAddress);
print(email);
print(token);


    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.userprofileUrl +'?email='+ email.toString(),
          token.toString());
      return response = ProfileDetailsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
