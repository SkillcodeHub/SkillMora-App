
import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';
import '../../Models/NotificationLIst_Model/notificationList_model.dart';
import '../../Res/app_url.dart';

class NotificationListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<NotificationListModel> fetchNotificationList(
      String ipAddress, String token) async {

    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.notificationListUrl + '?ipAddress=' + ipAddress.toString(),
          token.toString());
      return response = NotificationListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
