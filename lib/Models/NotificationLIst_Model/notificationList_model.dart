class NotificationListModel {
  bool? status;
  List<Notifications>? notifications;
  int? notifyCount;

  NotificationListModel({this.status, this.notifications, this.notifyCount});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    notifyCount = json['notifyCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    data['notifyCount'] = this.notifyCount;
    return data;
  }
}

class Notifications {
  UserDetails? userDetails;
  CompanyDetails? companyDetails;
  String? message;
  bool? isSeen;
  String? type;
  String? status;
  bool? msgRemoved;
  String? createdAt;

  Notifications(
      {this.userDetails,
      this.companyDetails,
      this.message,
      this.isSeen,
      this.type,
      this.status,
      this.msgRemoved,
      this.createdAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    companyDetails = json['companyDetails'] != null
        ? new CompanyDetails.fromJson(json['companyDetails'])
        : null;
    message = json['message'];
    isSeen = json['isSeen'];
    type = json['type'];
    status = json['status'];
    msgRemoved = json['msg_removed'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    if (this.companyDetails != null) {
      data['companyDetails'] = this.companyDetails!.toJson();
    }
    data['message'] = this.message;
    data['isSeen'] = this.isSeen;
    data['type'] = this.type;
    data['status'] = this.status;
    data['msg_removed'] = this.msgRemoved;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class UserDetails {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? workStatus;
  String? userProfilePhoto;
  String? currentCity;
  String? aboutUser;
  String? isVerified;

  UserDetails(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.workStatus,
      this.userProfilePhoto,
      this.currentCity,
      this.aboutUser,
      this.isVerified});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    workStatus = json['workStatus'];
    userProfilePhoto = json['userProfilePhoto'];
    currentCity = json['currentCity'];
    aboutUser = json['aboutUser'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['workStatus'] = this.workStatus;
    data['userProfilePhoto'] = this.userProfilePhoto;
    data['currentCity'] = this.currentCity;
    data['aboutUser'] = this.aboutUser;
    data['isVerified'] = this.isVerified;
    return data;
  }
}

class CompanyDetails {
  int? companyId;
  String? companyName;
  String? companyEmail;
  String? companyMobile;
  String? companyCity;
  String? companyState;
  String? companyPincode;
  String? companyCountry;
  String? companyAddress;
  String? companyLogo;
  String? companyWebsite;

  CompanyDetails(
      {this.companyId,
      this.companyName,
      this.companyEmail,
      this.companyMobile,
      this.companyCity,
      this.companyState,
      this.companyPincode,
      this.companyCountry,
      this.companyAddress,
      this.companyLogo,
      this.companyWebsite});

  CompanyDetails.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
    companyEmail = json['companyEmail'];
    companyMobile = json['companyMobile'];
    companyCity = json['companyCity'];
    companyState = json['companyState'];
    companyPincode = json['companyPincode'];
    companyCountry = json['companyCountry'];
    companyAddress = json['companyAddress'];
    companyLogo = json['companyLogo'];
    companyWebsite = json['companyWebsite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['companyName'] = this.companyName;
    data['companyEmail'] = this.companyEmail;
    data['companyMobile'] = this.companyMobile;
    data['companyCity'] = this.companyCity;
    data['companyState'] = this.companyState;
    data['companyPincode'] = this.companyPincode;
    data['companyCountry'] = this.companyCountry;
    data['companyAddress'] = this.companyAddress;
    data['companyLogo'] = this.companyLogo;
    data['companyWebsite'] = this.companyWebsite;
    return data;
  }
}
