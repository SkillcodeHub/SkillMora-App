

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';
import '../../../Models/GetSkillList_Model/getSkillList_model.dart';
import '../../../Res/app_url.dart';

class GetSkillListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<GetSkillListModel> fetchGetSkillList(
      String ipAddress, String token) async {

    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getSkillListUrl + '?ipAddress=' + ipAddress.toString(),
          token.toString());
      return response = GetSkillListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
