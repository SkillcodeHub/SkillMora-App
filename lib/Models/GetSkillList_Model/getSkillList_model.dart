class GetSkillListModel {
  List<KeySkillsList>? keySkillsList;
  bool? status;

  GetSkillListModel({this.keySkillsList, this.status});

  GetSkillListModel.fromJson(Map<String, dynamic> json) {
    if (json['keySkillsList'] != null) {
      keySkillsList = <KeySkillsList>[];
      json['keySkillsList'].forEach((v) {
        keySkillsList!.add(new KeySkillsList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.keySkillsList != null) {
      data['keySkillsList'] =
          this.keySkillsList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class KeySkillsList {
  int? id;
  ClientDetails? clientDetails;
  CourseDetails? courseDetails;
  String? skillName;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  KeySkillsList(
      {this.id,
      this.clientDetails,
      this.courseDetails,
      this.skillName,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  KeySkillsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    courseDetails = json['courseDetails'] != null
        ? new CourseDetails.fromJson(json['courseDetails'])
        : null;
    skillName = json['skillName'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.clientDetails != null) {
      data['clientDetails'] = this.clientDetails!.toJson();
    }
    if (this.courseDetails != null) {
      data['courseDetails'] = this.courseDetails!.toJson();
    }
    data['skillName'] = this.skillName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class ClientDetails {
  int? id;
  String? clientName;
  String? companyName;
  String? gstNo;
  String? address;

  ClientDetails(
      {this.id, this.clientName, this.companyName, this.gstNo, this.address});

  ClientDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['clientName'];
    companyName = json['companyName'];
    gstNo = json['gstNo'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clientName'] = this.clientName;
    data['companyName'] = this.companyName;
    data['gstNo'] = this.gstNo;
    data['address'] = this.address;
    return data;
  }
}

class CourseDetails {
  int? id;
  String? courseName;

  CourseDetails({this.id, this.courseName});

  CourseDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['courseName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['courseName'] = this.courseName;
    return data;
  }
}
