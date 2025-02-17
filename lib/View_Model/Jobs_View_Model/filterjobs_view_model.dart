import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Models/FilterJobs/filterJobList_model.dart';
import '../../Repository/Jobs_Repository/filterJobs_repository.dart';

class FilterJobsViewmodel with ChangeNotifier {
  final _myRepo = FilterJobsRepository();
  ApiResponse<FilterJobsModel> filterJobsList = ApiResponse.loading();
  setFilterJobsList(ApiResponse<FilterJobsModel> response) {
    filterJobsList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchFilterJobsApi(String limit, String offset, String clientId,
      String ipAddress,  Map<String, String> data,String token) async {
    setFilterJobsList(ApiResponse.loading());
    _myRepo
        .fetchFilterJobsApi(limit, offset, clientId, ipAddress,data, token )
        .then((value) {
      setFilterJobsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setFilterJobsList(ApiResponse.error(error.toString()));
    });
  }
}
