import 'package:skillmoraskh_app/Models/ProfileDetails_Model/WorkExperience_Model/departmentType_model.dart';

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';
import '../../../Res/app_url.dart';

class DepartmentTypeListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<DepartmentTypeListModel> fetchDepartmentTypeList(
      String ipAddress, String token) async {
print(ipAddress);
print(token);


    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.departmenttypeListUrl +'?ipAddress='+ ipAddress.toString(),
          token.toString());
      return response = DepartmentTypeListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
