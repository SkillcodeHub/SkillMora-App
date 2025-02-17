class AppliedJobsModel {
  bool? status;
  List<AppliedJobs>? appliedJobs;

  AppliedJobsModel({this.status, this.appliedJobs});

  AppliedJobsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['appliedJobs'] != null) {
      appliedJobs = <AppliedJobs>[];
      json['appliedJobs'].forEach((v) {
        appliedJobs!.add(new AppliedJobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.appliedJobs != null) {
      data['appliedJobs'] = this.appliedJobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppliedJobs {
  int? id;
  ClientDetails? clientDetails;
  UserDetails? userDetails;
  JobDetails? jobDetails;
  String? coverLetter;
  String? status;
  String? appliedAt;
  String? statusUpdatedAt;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  AppliedJobs(
      {this.id,
      this.clientDetails,
      this.userDetails,
      this.jobDetails,
      this.coverLetter,
      this.status,
      this.appliedAt,
      this.statusUpdatedAt,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  AppliedJobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    jobDetails = json['jobDetails'] != null
        ? new JobDetails.fromJson(json['jobDetails'])
        : null;
    coverLetter = json['coverLetter'];
    status = json['status'];
    appliedAt = json['appliedAt'];
    statusUpdatedAt = json['statusUpdatedAt'];
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
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    if (this.jobDetails != null) {
      data['jobDetails'] = this.jobDetails!.toJson();
    }
    data['coverLetter'] = this.coverLetter;
    data['status'] = this.status;
    data['appliedAt'] = this.appliedAt;
    data['statusUpdatedAt'] = this.statusUpdatedAt;
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

class UserDetails {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? workStatus;
  String? currentCity;
  String? isVerified;
  String? aboutUser;
  String? userProfilePhoto;

  UserDetails(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.workStatus,
      this.currentCity,
      this.isVerified,
      this.aboutUser,
      this.userProfilePhoto});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    workStatus = json['workStatus'];
    currentCity = json['currentCity'];
    isVerified = json['isVerified'];
    aboutUser = json['aboutUser'];
    userProfilePhoto = json['userProfilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['workStatus'] = this.workStatus;
    data['currentCity'] = this.currentCity;
    data['isVerified'] = this.isVerified;
    data['aboutUser'] = this.aboutUser;
    data['userProfilePhoto'] = this.userProfilePhoto;
    return data;
  }
}

class JobDetails {
  int? id;
  CompanyDetails? companyDetails;
  String? jobTitle;
  String? jobType;
  String? jobCity;
  String? jobArea;
  String? jobPincode;
  EmploymentType? employmentType;
  String? jobSchedule;
  String? jobStartDate;
  String? noOfVacancy;
  PayByDetails? payByDetails;
  String? amount;
  String? payRate;
  String? jobDescription;
  String? applicationDeadline;
  String? isRequireCv;
  String? keyQualifications;
  String? jobPerks;
  MinEducationDetails? minEducationDetails;
  String? createdAt;
  String? isActive;

  JobDetails(
      {this.id,
      this.companyDetails,
      this.jobTitle,
      this.jobType,
      this.jobCity,
      this.jobArea,
      this.jobPincode,
      this.employmentType,
      this.jobSchedule,
      this.jobStartDate,
      this.noOfVacancy,
      this.payByDetails,
      this.amount,
      this.payRate,
      this.jobDescription,
      this.applicationDeadline,
      this.isRequireCv,
      this.keyQualifications,
      this.jobPerks,
      this.minEducationDetails,
      this.createdAt,
      this.isActive});

  JobDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyDetails = json['companyDetails'] != null
        ? new CompanyDetails.fromJson(json['companyDetails'])
        : null;
    jobTitle = json['jobTitle'];
    jobType = json['jobType'];
    jobCity = json['jobCity'];
    jobArea = json['jobArea'];
    jobPincode = json['jobPincode'];
    employmentType = json['employmentType'] != null
        ? new EmploymentType.fromJson(json['employmentType'])
        : null;
    jobSchedule = json['jobSchedule'];
    jobStartDate = json['jobStartDate'];
    noOfVacancy = json['noOfVacancy'];
    payByDetails = json['payByDetails'] != null
        ? new PayByDetails.fromJson(json['payByDetails'])
        : null;
    amount = json['amount'];
    payRate = json['payRate'];
    jobDescription = json['jobDescription'];
    applicationDeadline = json['applicationDeadline'];
    isRequireCv = json['isRequireCv'];
    keyQualifications = json['keyQualifications'];
    jobPerks = json['jobPerks'];
    minEducationDetails = json['minEducationDetails'] != null
        ? new MinEducationDetails.fromJson(json['minEducationDetails'])
        : null;
    createdAt = json['created_at'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.companyDetails != null) {
      data['companyDetails'] = this.companyDetails!.toJson();
    }
    data['jobTitle'] = this.jobTitle;
    data['jobType'] = this.jobType;
    data['jobCity'] = this.jobCity;
    data['jobArea'] = this.jobArea;
    data['jobPincode'] = this.jobPincode;
    if (this.employmentType != null) {
      data['employmentType'] = this.employmentType!.toJson();
    }
    data['jobSchedule'] = this.jobSchedule;
    data['jobStartDate'] = this.jobStartDate;
    data['noOfVacancy'] = this.noOfVacancy;
    if (this.payByDetails != null) {
      data['payByDetails'] = this.payByDetails!.toJson();
    }
    data['amount'] = this.amount;
    data['payRate'] = this.payRate;
    data['jobDescription'] = this.jobDescription;
    data['applicationDeadline'] = this.applicationDeadline;
    data['isRequireCv'] = this.isRequireCv;
    data['keyQualifications'] = this.keyQualifications;
    data['jobPerks'] = this.jobPerks;
    if (this.minEducationDetails != null) {
      data['minEducationDetails'] = this.minEducationDetails!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['isActive'] = this.isActive;
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

class EmploymentType {
  int? id;
  String? courseTypeName;

  EmploymentType({this.id, this.courseTypeName});

  EmploymentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseTypeName = json['courseTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['courseTypeName'] = this.courseTypeName;
    return data;
  }
}

class PayByDetails {
  int? id;
  String? payByOption;

  PayByDetails({this.id, this.payByOption});

  PayByDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payByOption = json['payByOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payByOption'] = this.payByOption;
    return data;
  }
}

class MinEducationDetails {
  int? id;
  String? qualificationName;
  String? courseName;
  String? specificationName;

  MinEducationDetails(
      {this.id,
      this.qualificationName,
      this.courseName,
      this.specificationName});

  MinEducationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qualificationName = json['qualificationName'];
    courseName = json['courseName'];
    specificationName = json['specificationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qualificationName'] = this.qualificationName;
    data['courseName'] = this.courseName;
    data['specificationName'] = this.specificationName;
    return data;
  }
}
