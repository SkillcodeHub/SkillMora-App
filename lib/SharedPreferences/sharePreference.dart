import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/Components/Permission/permission.dart';

class UserPreferences {
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_token");
  }

  Future<void> setToken(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_token", args);
  }

  Future<String?> getsubcriptionDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_subcriptionDate");
  }

  void setsubcriptionDate(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_subcriptionDate", args);
  }



Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(userData));
  }

  Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

// Updated SharedPreferences methods
  static const String PERMISSIONS_KEY = 'permissions';

  Future<void> savePermissions(List<dynamic> permissions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Convert raw permission data to Permission objects then to JSON
    List<PermissionModel> permissionObjects = permissions.map((json) {
      return PermissionModel.fromJson(json);
    }).toList();
    
    // Convert to JSON string with explicit boolean values
    String jsonString = jsonEncode(
      permissionObjects.map((p) => p.toJson()).toList()
    );
    
    await prefs.setString(PERMISSIONS_KEY, jsonString);
  }

  Future<List<PermissionModel>> getPermissions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? permissionsString = prefs.getString(PERMISSIONS_KEY);
    
    if (permissionsString != null) {
      List<dynamic> jsonList = jsonDecode(permissionsString);
      return jsonList.map((json) => PermissionModel.fromJson(json)).toList();
    }
    return [];
  }





  // // New method to save permissions
  // Future<void> savePermissions(List<dynamic> permissions) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('permissions', jsonEncode(permissions));
  // }

  // // New method to get permissions
  // Future<List<PermissionModel>> getPermissions() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? permissionsString = prefs.getString('permissions');
  //   if (permissionsString != null) {
  //     List<dynamic> permissionsList = jsonDecode(permissionsString);
  //     return permissionsList
  //         .map((json) => Permission.fromJson(json))
  //         .toList();
  //   }
  //   return [];
  // }



 // Future<String?> getCmsToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("access_cmsToken");
  // }

  // void setCmsToken(String args) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("access_cmsToken", args);
  // }

  // Future<String?> getAxonToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("access_axonToken");
  // }

  // void setAxonToken(String args) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("access_axonToken", args);
  // }

  // Future<String?> getSrId() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("access_srId");
  // }

  // void setSrId(String args) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("access_srId", args);
  // }

  // void saveUserData(Map<String, dynamic> userData) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('userData', jsonEncode(userData));
  // }

  // Future<Map<String, dynamic>?> getUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userDataString = prefs.getString('userData');
  //   if (userDataString != null) {
  //     Map<String, dynamic> userData = jsonDecode(userDataString);
  //     return userData;
  //   } else {
  //     return null;
  //   }
  // }

  Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_email");
  }

  void setEmail(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_email", args);
  }

  // Future<String?> getIsAccessWebAPP() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("access_isAccessWebAPP");
  // }

  // void setIsAccessWebAPP(String args) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("access_isAccessWebAPP", args);
  // }

  Future<String?> getUserEFAW() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_userefaw");
  }

  Future<void> setUserEFAW(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_userefaw", args);
  }

  // Future<String?> getSoftwareId() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("access_softwareId");
  // }

  // void setSoftwareId(String args) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("access_softwareId", args);
  // }

  void logoutProcess() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("access_token");
    prefs.remove("access_email");
    prefs.remove("access_userefaw");
    prefs.remove("access_subcriptionDate");
    prefs.remove("alertCount");
    prefs.remove('permissions');

    // prefs.remove("access_doctor");
  }
}




