class FilterJobsModel {
  PaginationDetails? paginationDetails;
  List<CompanyJobsList>? companyJobsList;
  bool? status;

  FilterJobsModel({this.paginationDetails, this.companyJobsList, this.status});

  FilterJobsModel.fromJson(Map<String, dynamic> json) {
    paginationDetails = json['paginationDetails'] != null
        ? new PaginationDetails.fromJson(json['paginationDetails'])
        : null;
    if (json['companyJobsList'] != null) {
      companyJobsList = <CompanyJobsList>[];
      json['companyJobsList'].forEach((v) {
        companyJobsList!.add(new CompanyJobsList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paginationDetails != null) {
      data['paginationDetails'] = this.paginationDetails!.toJson();
    }
    if (this.companyJobsList != null) {
      data['companyJobsList'] =
          this.companyJobsList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class PaginationDetails {
  int? count;
  String? limit;
  String? offset;

  PaginationDetails({this.count, this.limit, this.offset});

  PaginationDetails.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    limit = json['limit'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    return data;
  }
}

class CompanyJobsList {
  int? id;
  CompanyDetails? companyDetails;
  PayByDetails? payByDetails;
  MinEducationsDetails? minEducationsDetails;
  EmploymentTypeDetails? employmentTypeDetails;
  EducationQualificationDetails? educationQualificationDetails;
  CourseDetails? courseDetails;
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
  String? applicationDeadline;
  String? isRequireCv;
  String? keyQualifications;
  String? isActive;
  String? jobPerks;
  String? requiredExperience;
  int? applicantCount;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  CompanyJobsList(
      {this.id,
      this.companyDetails,
      this.payByDetails,
      this.minEducationsDetails,
      this.employmentTypeDetails,
      this.educationQualificationDetails,
      this.courseDetails,
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
      this.applicantCount,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  CompanyJobsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyDetails = json['companyDetails'] != null
        ? new CompanyDetails.fromJson(json['companyDetails'])
        : null;
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
    applicantCount = json['applicant_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.companyDetails != null) {
      data['companyDetails'] = this.companyDetails!.toJson();
    }
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
    data['applicant_count'] = this.applicantCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class CompanyDetails {
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
  List<CompanyLocationsDetails>? companyLocationsDetails;
  List<CompanySubscriptionsDetails>? companySubscriptionsDetails;
  List<CompanyTransectionsDetails>? companyTransectionsDetails;
  List<CompanyJobsDetails>? companyJobsDetails;
  List<CompanyReviewDetails>? companyReviewDetails;
  String? isVerified;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  CompanyDetails(
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
      this.companyLocationsDetails,
      this.companySubscriptionsDetails,
      this.companyTransectionsDetails,
      this.companyJobsDetails,
      this.companyReviewDetails,
      this.isVerified,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  CompanyDetails.fromJson(Map<String, dynamic> json) {
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
    if (json['companyLocationsDetails'] != null) {
      companyLocationsDetails = <CompanyLocationsDetails>[];
      json['companyLocationsDetails'].forEach((v) {
        companyLocationsDetails!.add(new CompanyLocationsDetails.fromJson(v));
      });
    }
    if (json['companySubscriptionsDetails'] != null) {
      companySubscriptionsDetails = <CompanySubscriptionsDetails>[];
      json['companySubscriptionsDetails'].forEach((v) {
        companySubscriptionsDetails!
            .add(new CompanySubscriptionsDetails.fromJson(v));
      });
    }
    if (json['companyTransectionsDetails'] != null) {
      companyTransectionsDetails = <CompanyTransectionsDetails>[];
      json['companyTransectionsDetails'].forEach((v) {
        companyTransectionsDetails!
            .add(new CompanyTransectionsDetails.fromJson(v));
      });
    }
    if (json['companyJobsDetails'] != null) {
      companyJobsDetails = <CompanyJobsDetails>[];
      json['companyJobsDetails'].forEach((v) {
        companyJobsDetails!.add(new CompanyJobsDetails.fromJson(v));
      });
    }
    if (json['companyReviewDetails'] != null) {
      companyReviewDetails = <CompanyReviewDetails>[];
      json['companyReviewDetails'].forEach((v) {
        companyReviewDetails!.add(new CompanyReviewDetails.fromJson(v));
      });
    }
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
    if (this.companyLocationsDetails != null) {
      data['companyLocationsDetails'] =
          this.companyLocationsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.companySubscriptionsDetails != null) {
      data['companySubscriptionsDetails'] =
          this.companySubscriptionsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.companyTransectionsDetails != null) {
      data['companyTransectionsDetails'] =
          this.companyTransectionsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.companyJobsDetails != null) {
      data['companyJobsDetails'] =
          this.companyJobsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.companyReviewDetails != null) {
      data['companyReviewDetails'] =
          this.companyReviewDetails!.map((v) => v.toJson()).toList();
    }
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

class CompanySubscriptionsDetails {
  int? id;
  PackageId? packageId;
  String? startDate;
  String? endDate;
  String? isActive;

  CompanySubscriptionsDetails(
      {this.id, this.packageId, this.startDate, this.endDate, this.isActive});

  CompanySubscriptionsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['packageId'] != null
        ? new PackageId.fromJson(json['packageId'])
        : null;
    startDate = json['startDate'];
    endDate = json['endDate'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.packageId != null) {
      data['packageId'] = this.packageId!.toJson();
    }
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['isActive'] = this.isActive;
    return data;
  }
}

class PackageId {
  int? id;
  String? packageName;
  String? price;
  String? jobPostingLimit;
  String? allowedApplications;
  String? durationInDays;

  PackageId(
      {this.id,
      this.packageName,
      this.price,
      this.jobPostingLimit,
      this.allowedApplications,
      this.durationInDays});

  PackageId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageName = json['packageName'];
    price = json['price'];
    jobPostingLimit = json['jobPostingLimit'];
    allowedApplications = json['allowedApplications'];
    durationInDays = json['durationInDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['packageName'] = this.packageName;
    data['price'] = this.price;
    data['jobPostingLimit'] = this.jobPostingLimit;
    data['allowedApplications'] = this.allowedApplications;
    data['durationInDays'] = this.durationInDays;
    return data;
  }
}

class CompanyTransectionsDetails {
  int? id;
  PackageId? packageDetails;
  SubscriptionDetails? subscriptionDetails;
  String? transectionStatus;
  String? transectionType;
  String? transectionId;
  String? razorpayOrderId;
  String? transectionSignature;
  String? transectionTime;

  CompanyTransectionsDetails(
      {this.id,
      this.packageDetails,
      this.subscriptionDetails,
      this.transectionStatus,
      this.transectionType,
      this.transectionId,
      this.razorpayOrderId,
      this.transectionSignature,
      this.transectionTime});

  CompanyTransectionsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageDetails = json['packageDetails'] != null
        ? new PackageId.fromJson(json['packageDetails'])
        : null;
    subscriptionDetails = json['subscriptionDetails'] != null
        ? new SubscriptionDetails.fromJson(json['subscriptionDetails'])
        : null;
    transectionStatus = json['transectionStatus'];
    transectionType = json['transectionType'];
    transectionId = json['transectionId'];
    razorpayOrderId = json['razorpayOrderId'];
    transectionSignature = json['transectionSignature'];
    transectionTime = json['transectionTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.packageDetails != null) {
      data['packageDetails'] = this.packageDetails!.toJson();
    }
    if (this.subscriptionDetails != null) {
      data['subscriptionDetails'] = this.subscriptionDetails!.toJson();
    }
    data['transectionStatus'] = this.transectionStatus;
    data['transectionType'] = this.transectionType;
    data['transectionId'] = this.transectionId;
    data['razorpayOrderId'] = this.razorpayOrderId;
    data['transectionSignature'] = this.transectionSignature;
    data['transectionTime'] = this.transectionTime;
    return data;
  }
}

class SubscriptionDetails {
  int? id;
  String? startDate;
  String? endDate;
  String? isActive;

  SubscriptionDetails({this.id, this.startDate, this.endDate, this.isActive});

  SubscriptionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['isActive'] = this.isActive;
    return data;
  }
}

class CompanyJobsDetails {
  int? id;
  PayByDetails? payByDetails;
  MinEducationsDetails? minEducationsDetails;
  EmploymentTypeDetails? employmentTypeDetails;
  EducationQualificationDetails? educationQualificationDetails;
  CourseDetails? courseDetails;
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
  String? applicationDeadline;
  String? isRequireCv;
  String? keyQualifications;
  String? isActive;
  String? jobPerks;
  String? requiredExperience;

  CompanyJobsDetails(
      {this.id,
      this.payByDetails,
      this.minEducationsDetails,
      this.employmentTypeDetails,
      this.educationQualificationDetails,
      this.courseDetails,
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
      this.requiredExperience});

  CompanyJobsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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

class CompanyReviewDetails {
  int? id;
  String? name;
  String? rating;
  String? comment;
  UserDetails? userDetails;

  CompanyReviewDetails(
      {this.id, this.name, this.rating, this.comment, this.userDetails});

  CompanyReviewDetails.fromJson(Map<String, dynamic> json) {
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

// class MinEducationsDetails {
//   int? id;
//   String? specificationName;
//   CourseDetails? courseDetails;

//   MinEducationsDetails({this.id, this.specificationName, this.courseDetails});

//   MinEducationsDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     specificationName = json['specificationName'];
//     courseDetails = json['courseDetails'] != null
//         ? new CourseDetails.fromJson(json['courseDetails'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['specificationName'] = this.specificationName;
//     if (this.courseDetails != null) {
//       data['courseDetails'] = this.courseDetails!.toJson();
//     }
//     return data;
//   }
// }

// class CourseDetails {
//   int? id;
//   String? courseName;
//   EducationQualificationDetails? qualificationDetails;

//   CourseDetails({this.id, this.courseName, this.qualificationDetails});

//   CourseDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     courseName = json['courseName'];
//     qualificationDetails = json['qualificationDetails'] != null
//         ? new EducationQualificationDetails.fromJson(
//             json['qualificationDetails'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['courseName'] = this.courseName;
//     if (this.qualificationDetails != null) {
//       data['qualificationDetails'] = this.qualificationDetails!.toJson();
//     }
//     return data;
//   }
// }
