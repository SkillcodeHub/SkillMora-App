import 'package:flutter/material.dart';
import '../../Data/Response/api_response.dart';
import '../../Models/CompanyDetails_Model/companyDetails_model.dart';
import '../../Repository/CompanyDetails_Repository/companyDetailsById_repository.dart';

class CompanyDetailsByIdViewmodel with ChangeNotifier {
  final _myRepo = CompanyDetailsByIdRepository();
  ApiResponse<CompanyDetailsByIdModel> companyDetailsById = ApiResponse.loading();
  String? DeviceType;

  setCompanyDetailsById(ApiResponse<CompanyDetailsByIdModel> response) {
    companyDetailsById = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchCompanyDetailsByIdApi(
      String ipAddress, String companyId,String token) async {
    setCompanyDetailsById(ApiResponse.loading());

    try {
      final value = await _myRepo.fetchCompanyDetailsById(ipAddress,companyId, token);
      setCompanyDetailsById(ApiResponse.completed(value));
    } catch (error) {
      setCompanyDetailsById(ApiResponse.error(error.toString()));
    }
  }
}
