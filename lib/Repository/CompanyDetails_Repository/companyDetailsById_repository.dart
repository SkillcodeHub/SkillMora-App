
import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Models/CompanyDetails_Model/companyDetails_model.dart';
import '../../Res/app_url.dart';

class CompanyDetailsByIdRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<CompanyDetailsByIdModel> fetchCompanyDetailsById(
      String ipAddress,String companyId,String token) async {

    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.companydetailbyIdUrl + '?ipAddress=' + ipAddress.toString() +"&companyId="+ companyId.toString(),
          token.toString());
      return response = CompanyDetailsByIdModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
