import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';
import '../../Models/NotificationLIst_Model/notificationList_model.dart';
import '../../Repository/NotificationList_Repository/notificationList_repository.dart';

class NotificationListViewmodel with ChangeNotifier {
  final _myRepo = NotificationListRepository();
  ApiResponse<NotificationListModel> notificationList =
      ApiResponse.loading();




  setNotificationList(
      ApiResponse<NotificationListModel> response) {
    notificationList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchNotificationListApi(
    
      String ipAddress,
      String token) async {

    setNotificationList(ApiResponse.loading());

    try {
      final value = await _myRepo.fetchNotificationList(
          ipAddress ,token);
      setNotificationList(ApiResponse.completed(value));
     } catch (error) {
      setNotificationList(ApiResponse.error(error.toString()));
      }
  }


}
