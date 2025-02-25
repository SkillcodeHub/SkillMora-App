import 'package:flutter/material.dart';
import 'package:skillmoraskh_app/Models/ProfileDetails_Model/WorkExperience_Model/workExperience_model.dart';
import 'package:skillmoraskh_app/Repository/Profile_Repository/WorkExperience_repository/industryTypeList_repository.dart';

import '../../../Data/Response/api_response.dart';

class IndustryTypeListViewModel with ChangeNotifier {
  final _myRepo = IndustryTypeListRepository();
  ApiResponse<IndustryTypeListModel> industryTypeList = ApiResponse.loading();

  setIndustryTypeList(ApiResponse<IndustryTypeListModel> response) {
    industryTypeList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchIndustryTypeListApi(String ipAddress, String email,String token) async {
    setIndustryTypeList(ApiResponse.loading());

    try {
      final value = await _myRepo.fetchIndustryTypeList(ipAddress, token);
      setIndustryTypeList(ApiResponse.completed(value));
    } catch (error) {
      setIndustryTypeList(ApiResponse.error(error.toString()));
    }
  }
}
