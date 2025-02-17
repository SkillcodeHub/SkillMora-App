import 'dart:io';
import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Models/FilterJobs/filterJobList_model.dart';
import '../../Models/FilterJobs/savedJobList_model.dart';
import '../../Repository/Jobs_Repository/savedJobs_repository.dart';

class GetSavedJobsListViewmodel with ChangeNotifier {
  final _myRepo = GetSavedJobsListRepository();
  ApiResponse<SavedJobsModel> getSavedJobsList = ApiResponse.loading();

  String? DeviceType;

  setSavedJobsList(ApiResponse<SavedJobsModel> response) {
    getSavedJobsList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchSavedJobsListApi(String ipAddress, String token) async {
    setSavedJobsList(ApiResponse.loading());

    try {
      final value = await _myRepo.fetchSavedJobsList(ipAddress, token);
      setSavedJobsList(ApiResponse.completed(value));
    } catch (error) {
      setSavedJobsList(ApiResponse.error(error.toString()));
    }
  }
}
