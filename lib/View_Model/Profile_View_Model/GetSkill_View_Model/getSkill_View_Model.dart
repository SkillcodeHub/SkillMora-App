import 'package:flutter/material.dart';

import '../../../Data/Response/api_response.dart';
import '../../../Models/GetSkillList_Model/getSkillList_model.dart';
import '../../../Repository/Profile_Repository/GetSkillList_Repository/getSkillList_repository.dart';

class GetSkillListViewmodel with ChangeNotifier {
  final _myRepo = GetSkillListRepository();
  ApiResponse<GetSkillListModel> getSkillList = ApiResponse.loading();

  setGetSkillList(ApiResponse<GetSkillListModel> response) {
    getSkillList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchGetSkillListApi(String ipAddress, String token) async {
    setGetSkillList(ApiResponse.loading());

    try {
      final value = await _myRepo.fetchGetSkillList(ipAddress, token);
      setGetSkillList(ApiResponse.completed(value));
    } catch (error) {
      setGetSkillList(ApiResponse.error(error.toString()));
    }
  }
}
