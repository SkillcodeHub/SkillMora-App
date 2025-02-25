class IndustryTypeListModel {
  List<IndustryList>? industryList;
  bool? status;

  IndustryTypeListModel({this.industryList, this.status});

  IndustryTypeListModel.fromJson(Map<String, dynamic> json) {
    if (json['industryList'] != null) {
      industryList = <IndustryList>[];
      json['industryList'].forEach((v) {
        industryList!.add(new IndustryList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.industryList != null) {
      data['industryList'] = this.industryList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class IndustryList {
  int? id;
  ClientDetails? clientDetails;
  String? typeName;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  IndustryList(
      {this.id,
      this.clientDetails,
      this.typeName,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  IndustryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    typeName = json['typeName'];
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
    data['typeName'] = this.typeName;
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
