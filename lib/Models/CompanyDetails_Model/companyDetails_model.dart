class CompanyDetailsByIdModel {
  bool? status;
  List<ComapnyDetail>? comapnyDetail;

  CompanyDetailsByIdModel({this.status, this.comapnyDetail});

  CompanyDetailsByIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['comapnyDetail'] != null) {
      comapnyDetail = <ComapnyDetail>[];
      json['comapnyDetail'].forEach((v) {
        comapnyDetail!.add(new ComapnyDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.comapnyDetail != null) {
      data['comapnyDetail'] =
          this.comapnyDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComapnyDetail {
  int? id;
  String? companyName;
  String? companyEmail;
  String? companyMobile;
  String? noOfEmployee;
  String? city;
  String? state;
  String? pincode;
  String? country;
  String? companyAddress;
  IndustryTypeDetails? industryTypeDetails;
  String? companyWebsite;
  String? companyLogo;
  String? companyFoundationYear;
  String? companyDescription;
  String? companyRating;
  String? panImage;
  String? gstNo;
  String? panNo;
  String? tanNo;
  String? cinNo;
  List<CompanySocialMediaDetails>? companySocialMediaDetails;
  List<CompanyReviewsDetails>? companyReviewsDetails;
  List<CompanyLocationsDetails>? companyLocationsDetails;
  List<CompanyJobsDetails>? companyJobsDetails;
  String? jobPostingLimit;
  String? packageEndDate;
  String? isVerified;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  ComapnyDetail(
      {this.id,
      this.companyName,
      this.companyEmail,
      this.companyMobile,
      this.noOfEmployee,
      this.city,
      this.state,
      this.pincode,
      this.country,
      this.companyAddress,
      this.industryTypeDetails,
      this.companyWebsite,
      this.companyLogo,
      this.companyFoundationYear,
      this.companyDescription,
      this.companyRating,
      this.panImage,
      this.gstNo,
      this.panNo,
      this.tanNo,
      this.cinNo,
      this.companySocialMediaDetails,
      this.companyReviewsDetails,
      this.companyLocationsDetails,
      this.companyJobsDetails,
      this.jobPostingLimit,
      this.packageEndDate,
      this.isVerified,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  ComapnyDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    companyEmail = json['companyEmail'];
    companyMobile = json['companyMobile'];
    noOfEmployee = json['noOfEmployee'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
    companyAddress = json['companyAddress'];
    industryTypeDetails = json['industryTypeDetails'] != null
        ? new IndustryTypeDetails.fromJson(json['industryTypeDetails'])
        : null;
    companyWebsite = json['companyWebsite'];
    companyLogo = json['companyLogo'];
    companyFoundationYear = json['companyFoundationYear'];
    companyDescription = json['companyDescription'];
    companyRating = json['companyRating'];
    panImage = json['panImage'];
    gstNo = json['gstNo'];
    panNo = json['panNo'];
    tanNo = json['tanNo'];
    cinNo = json['cinNo'];
    if (json['companySocialMediaDetails'] != null) {
      companySocialMediaDetails = <CompanySocialMediaDetails>[];
      json['companySocialMediaDetails'].forEach((v) {
        companySocialMediaDetails!
            .add(new CompanySocialMediaDetails.fromJson(v));
      });
    }
    if (json['companyReviewsDetails'] != null) {
      companyReviewsDetails = <CompanyReviewsDetails>[];
      json['companyReviewsDetails'].forEach((v) {
        companyReviewsDetails!.add(new CompanyReviewsDetails.fromJson(v));
      });
    }
    if (json['companyLocationsDetails'] != null) {
      companyLocationsDetails = <CompanyLocationsDetails>[];
      json['companyLocationsDetails'].forEach((v) {
        companyLocationsDetails!.add(new CompanyLocationsDetails.fromJson(v));
      });
    }
    if (json['companyJobsDetails'] != null) {
      companyJobsDetails = <CompanyJobsDetails>[];
      json['companyJobsDetails'].forEach((v) {
        companyJobsDetails!.add(new CompanyJobsDetails.fromJson(v));
      });
    }
    jobPostingLimit = json['jobPostingLimit'];
    packageEndDate = json['packageEndDate'];
    isVerified = json['isVerified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['companyEmail'] = this.companyEmail;
    data['companyMobile'] = this.companyMobile;
    data['noOfEmployee'] = this.noOfEmployee;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['country'] = this.country;
    data['companyAddress'] = this.companyAddress;
    if (this.industryTypeDetails != null) {
      data['industryTypeDetails'] = this.industryTypeDetails!.toJson();
    }
    data['companyWebsite'] = this.companyWebsite;
    data['companyLogo'] = this.companyLogo;
    data['companyFoundationYear'] = this.companyFoundationYear;
    data['companyDescription'] = this.companyDescription;
    data['companyRating'] = this.companyRating;
    data['panImage'] = this.panImage;
    data['gstNo'] = this.gstNo;
    data['panNo'] = this.panNo;
    data['tanNo'] = this.tanNo;
    data['cinNo'] = this.cinNo;
    if (this.companySocialMediaDetails != null) {
      data['companySocialMediaDetails'] =
          this.companySocialMediaDetails!.map((v) => v.toJson()).toList();
    }
    if (this.companyReviewsDetails != null) {
      data['companyReviewsDetails'] =
          this.companyReviewsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.companyLocationsDetails != null) {
      data['companyLocationsDetails'] =
          this.companyLocationsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.companyJobsDetails != null) {
      data['companyJobsDetails'] =
          this.companyJobsDetails!.map((v) => v.toJson()).toList();
    }
    data['jobPostingLimit'] = this.jobPostingLimit;
    data['packageEndDate'] = this.packageEndDate;
    data['isVerified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class IndustryTypeDetails {
  int? id;
  String? typeName;

  IndustryTypeDetails({this.id, this.typeName});

  IndustryTypeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['typeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typeName'] = this.typeName;
    return data;
  }
}

class CompanySocialMediaDetails {
  int? id;
  String? linkedin;
  String? github;
  String? facebook;
  String? instagram;
  String? twitter;

  CompanySocialMediaDetails(
      {this.id,
      this.linkedin,
      this.github,
      this.facebook,
      this.instagram,
      this.twitter});

  CompanySocialMediaDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    linkedin = json['linkedin'];
    github = json['github'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['linkedin'] = this.linkedin;
    data['github'] = this.github;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    return data;
  }
}

class CompanyReviewsDetails {
  int? id;
  String? name;
  String? rating;
  String? comment;
  UserDetails? userDetails;

  CompanyReviewsDetails(
      {this.id, this.name, this.rating, this.comment, this.userDetails});

  CompanyReviewsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
    comment = json['comment'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  int? id;
  String? userName;
  String? userEmail;
  String? userCity;
  String? userProfilePhoto;

  UserDetails(
      {this.id,
      this.userName,
      this.userEmail,
      this.userCity,
      this.userProfilePhoto});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userCity = json['userCity'];
    userProfilePhoto = json['userProfilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['userCity'] = this.userCity;
    data['userProfilePhoto'] = this.userProfilePhoto;
    return data;
  }
}

class CompanyLocationsDetails {
  int? id;
  String? companyAddress;
  String? city;
  String? state;
  String? country;

  CompanyLocationsDetails(
      {this.id, this.companyAddress, this.city, this.state, this.country});

  CompanyLocationsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyAddress = json['companyAddress'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyAddress'] = this.companyAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}

class CompanyJobsDetails {
  int? id;
  String? jobTitle;
  String? jobType;
  String? jobCity;
  String? jobArea;
  String? jobPincode;
  String? jobSchedule;
  String? jobStartDate;
  String? noOfVacancy;
  String? amount;
  String? payRate;
  String? jobDescription;
  Null? applicationDeadline;
  String? isRequireCv;
  String? keyQualifications;
  String? isActive;
  String? jobPerks;
  String? requiredExperience;
  PayByDetails? payByDetails;
  MinEducationsDetails? minEducationsDetails;
  EmploymentTypeDetails? employmentTypeDetails;
  EducationQualificationDetails? educationQualificationDetails;
  CourseDetails? courseDetails;

  CompanyJobsDetails(
      {this.id,
      this.jobTitle,
      this.jobType,
      this.jobCity,
      this.jobArea,
      this.jobPincode,
      this.jobSchedule,
      this.jobStartDate,
      this.noOfVacancy,
      this.amount,
      this.payRate,
      this.jobDescription,
      this.applicationDeadline,
      this.isRequireCv,
      this.keyQualifications,
      this.isActive,
      this.jobPerks,
      this.requiredExperience,
      this.payByDetails,
      this.minEducationsDetails,
      this.employmentTypeDetails,
      this.educationQualificationDetails,
      this.courseDetails});

  CompanyJobsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobTitle = json['jobTitle'];
    jobType = json['jobType'];
    jobCity = json['jobCity'];
    jobArea = json['jobArea'];
    jobPincode = json['jobPincode'];
    jobSchedule = json['jobSchedule'];
    jobStartDate = json['jobStartDate'];
    noOfVacancy = json['noOfVacancy'];
    amount = json['amount'];
    payRate = json['payRate'];
    jobDescription = json['jobDescription'];
    applicationDeadline = json['applicationDeadline'];
    isRequireCv = json['isRequireCv'];
    keyQualifications = json['keyQualifications'];
    isActive = json['isActive'];
    jobPerks = json['jobPerks'];
    requiredExperience = json['requiredExperience'];
    payByDetails = json['payByDetails'] != null
        ? new PayByDetails.fromJson(json['payByDetails'])
        : null;
    minEducationsDetails = json['minEducationsDetails'] != null
        ? new MinEducationsDetails.fromJson(json['minEducationsDetails'])
        : null;
    employmentTypeDetails = json['employmentTypeDetails'] != null
        ? new EmploymentTypeDetails.fromJson(json['employmentTypeDetails'])
        : null;
    educationQualificationDetails =
        json['educationQualificationDetails'] != null
            ? new EducationQualificationDetails.fromJson(
                json['educationQualificationDetails'])
            : null;
    courseDetails = json['courseDetails'] != null
        ? new CourseDetails.fromJson(json['courseDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobTitle'] = this.jobTitle;
    data['jobType'] = this.jobType;
    data['jobCity'] = this.jobCity;
    data['jobArea'] = this.jobArea;
    data['jobPincode'] = this.jobPincode;
    data['jobSchedule'] = this.jobSchedule;
    data['jobStartDate'] = this.jobStartDate;
    data['noOfVacancy'] = this.noOfVacancy;
    data['amount'] = this.amount;
    data['payRate'] = this.payRate;
    data['jobDescription'] = this.jobDescription;
    data['applicationDeadline'] = this.applicationDeadline;
    data['isRequireCv'] = this.isRequireCv;
    data['keyQualifications'] = this.keyQualifications;
    data['isActive'] = this.isActive;
    data['jobPerks'] = this.jobPerks;
    data['requiredExperience'] = this.requiredExperience;
    if (this.payByDetails != null) {
      data['payByDetails'] = this.payByDetails!.toJson();
    }
    if (this.minEducationsDetails != null) {
      data['minEducationsDetails'] = this.minEducationsDetails!.toJson();
    }
    if (this.employmentTypeDetails != null) {
      data['employmentTypeDetails'] = this.employmentTypeDetails!.toJson();
    }
    if (this.educationQualificationDetails != null) {
      data['educationQualificationDetails'] =
          this.educationQualificationDetails!.toJson();
    }
    if (this.courseDetails != null) {
      data['courseDetails'] = this.courseDetails!.toJson();
    }
    return data;
  }
}

class PayByDetails {
  int? id;
  String? name;

  PayByDetails({this.id, this.name});

  PayByDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class MinEducationsDetails {
  int? id;
  String? specificationName;

  MinEducationsDetails({this.id, this.specificationName});

  MinEducationsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specificationName = json['specificationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['specificationName'] = this.specificationName;
    return data;
  }
}

class EmploymentTypeDetails {
  int? id;
  String? courseTypeName;

  EmploymentTypeDetails({this.id, this.courseTypeName});

  EmploymentTypeDetails.fromJson(Map<String, dynamic> json) {
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

class EducationQualificationDetails {
  int? id;
  String? qualificationName;

  EducationQualificationDetails({this.id, this.qualificationName});

  EducationQualificationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qualificationName = json['qualificationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qualificationName'] = this.qualificationName;
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
