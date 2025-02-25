import 'package:flutter/material.dart';
import 'package:skillmoraskh_app/Models/ProfileDetails_Model/WorkExperience_Model/departmentType_model.dart';
import 'package:skillmoraskh_app/Repository/Profile_Repository/WorkExperience_repository/departmentTypeList_repository.dart';

import '../../../Data/Response/api_response.dart';

class DepartmentTypeListViewModel with ChangeNotifier {
  final _myRepo = DepartmentTypeListRepository();
  ApiResponse<DepartmentTypeListModel> departmentTypeList = ApiResponse.loading();

  setDepartmentTypeList(ApiResponse<DepartmentTypeListModel> response) {
    departmentTypeList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchDepartmentTypeListApi(String ipAddress, String email,String token) async {
    setDepartmentTypeList(ApiResponse.loading());

    try {
      final value = await _myRepo.fetchDepartmentTypeList(ipAddress,token);
      setDepartmentTypeList(ApiResponse.completed(value));
    } catch (error) {
      setDepartmentTypeList(ApiResponse.error(error.toString()));
    }
  }
}
