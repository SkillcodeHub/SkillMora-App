import 'package:skillmoraskh_app/Models/ProfileDetails_Model/WorkExperience_Model/workExperience_model.dart' show IndustryTypeListModel;

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';
import '../../../Res/app_url.dart';

class IndustryTypeListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<IndustryTypeListModel> fetchIndustryTypeList(
      String ipAddress, String token) async {
print(ipAddress);
print(token);


    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.industrytypeListUrl +'?ipAddress='+ ipAddress.toString(),
          token.toString());
      return response = IndustryTypeListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
