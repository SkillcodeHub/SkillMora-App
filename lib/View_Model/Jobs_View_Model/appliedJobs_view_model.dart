import 'dart:io';
import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Models/FilterJobs/appliedJobList_model.dart';
import '../../Repository/Jobs_Repository/appliedJobs_repository.dart';

class GetAppliedJobsListViewmodel with ChangeNotifier {
  final _myRepo = GetAppliedJobsListRepository();
  ApiResponse<AppliedJobsModel> getAppliedJobsList =
      ApiResponse.loading();




  setAppliedJobsList(
      ApiResponse<AppliedJobsModel> response) {
    getAppliedJobsList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchAppliedJobsListApi(
    
      String ipAddress,
      String token) async {

    setAppliedJobsList(ApiResponse.loading());

    try {
      final value = await _myRepo.fetchAppliedJobsList(
          ipAddress ,token);
      setAppliedJobsList(ApiResponse.completed(value));
     } catch (error) {
      setAppliedJobsList(ApiResponse.error(error.toString()));
      }
  }


}
