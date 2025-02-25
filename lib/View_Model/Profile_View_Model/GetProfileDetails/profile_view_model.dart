import 'package:flutter/material.dart';

import '../../../Data/Response/api_response.dart';
import '../../../Models/ProfileDetails_Model/profileDetails_model.dart';
import '../../../Repository/Profile_Repository/ProfileDetails_Repository/profileDetails_repository.dart';

class ProfileDetailsViewmodel with ChangeNotifier {
  final _myRepo = ProfileDetailsRepository();
  ApiResponse<ProfileDetailsModel> profileDetails = ApiResponse.loading();

  setProfileDetails(ApiResponse<ProfileDetailsModel> response) {
    profileDetails = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchProfileDetailsApi(String ipAddress, String email,String token) async {
    setProfileDetails(ApiResponse.loading());

    try {
      final value = await _myRepo.fetchProfileDetails(ipAddress, email,token);
      setProfileDetails(ApiResponse.completed(value));
    } catch (error) {
      setProfileDetails(ApiResponse.error(error.toString()));
    }
  }
}
