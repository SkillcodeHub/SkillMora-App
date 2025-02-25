class ProfileDetailsModel {
  List<UserBasicDetailsList>? userBasicDetailsList;
  bool? status;

  ProfileDetailsModel({this.userBasicDetailsList, this.status});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['userBasicDetailsList'] != null) {
      userBasicDetailsList = <UserBasicDetailsList>[];
      json['userBasicDetailsList'].forEach((v) {
        userBasicDetailsList!.add(new UserBasicDetailsList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userBasicDetailsList != null) {
      data['userBasicDetailsList'] =
          this.userBasicDetailsList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class UserBasicDetailsList {
  int? id;
  ClientDetails? clientDetails;
  String? name;
  String? email;
  String? mobile;
  String? workStatus;
  String? currentCity;
  String? userProfilePhoto;
  String? aboutUser;
  List<ResumeDetails>? resumeDetails;
  List<EmploymentDetails>? employmentDetails;
  List<KeySkillsDetails>? keySkillsDetails;
  List<EducationDetail>? educationDetail;
  List<OtherDetails>? otherDetails;
  List<SocialMediaDetails>? socialMediaDetails;
  List<CoursesCertificateDetails>? coursesCertificateDetails;
  List<ProjectDetails>? projectDetails;
  List<LanguageDetails>? languageDetails;
  int? profilePercentage;
  String? isVerified;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  UserBasicDetailsList(
      {this.id,
      this.clientDetails,
      this.name,
      this.email,
      this.mobile,
      this.workStatus,
      this.currentCity,
      this.userProfilePhoto,
      this.aboutUser,
      this.resumeDetails,
      this.employmentDetails,
      this.keySkillsDetails,
      this.educationDetail,
      this.otherDetails,
      this.socialMediaDetails,
      this.coursesCertificateDetails,
      this.projectDetails,
      this.languageDetails,
      this.profilePercentage,
      this.isVerified,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  UserBasicDetailsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    workStatus = json['workStatus'];
    currentCity = json['currentCity'];
    userProfilePhoto = json['userProfilePhoto'];
    aboutUser = json['aboutUser'];
    if (json['resumeDetails'] != null) {
      resumeDetails = <ResumeDetails>[];
      json['resumeDetails'].forEach((v) {
        resumeDetails!.add(new ResumeDetails.fromJson(v));
      });
    }
    if (json['employmentDetails'] != null) {
      employmentDetails = <EmploymentDetails>[];
      json['employmentDetails'].forEach((v) {
        employmentDetails!.add(new EmploymentDetails.fromJson(v));
      });
    }
    if (json['keySkillsDetails'] != null) {
      keySkillsDetails = <KeySkillsDetails>[];
      json['keySkillsDetails'].forEach((v) {
        keySkillsDetails!.add(new KeySkillsDetails.fromJson(v));
      });
    }
    if (json['educationDetail'] != null) {
      educationDetail = <EducationDetail>[];
      json['educationDetail'].forEach((v) {
        educationDetail!.add(new EducationDetail.fromJson(v));
      });
    }
    if (json['otherDetails'] != null) {
      otherDetails = <OtherDetails>[];
      json['otherDetails'].forEach((v) {
        otherDetails!.add(new OtherDetails.fromJson(v));
      });
    }
    if (json['socialMediaDetails'] != null) {
      socialMediaDetails = <SocialMediaDetails>[];
      json['socialMediaDetails'].forEach((v) {
        socialMediaDetails!.add(new SocialMediaDetails.fromJson(v));
      });
    }
    if (json['coursesCertificateDetails'] != null) {
      coursesCertificateDetails = <CoursesCertificateDetails>[];
      json['coursesCertificateDetails'].forEach((v) {
        coursesCertificateDetails!
            .add(new CoursesCertificateDetails.fromJson(v));
      });
    }
    if (json['projectDetails'] != null) {
      projectDetails = <ProjectDetails>[];
      json['projectDetails'].forEach((v) {
        projectDetails!.add(new ProjectDetails.fromJson(v));
      });
    }
    if (json['languageDetails'] != null) {
      languageDetails = <LanguageDetails>[];
      json['languageDetails'].forEach((v) {
        languageDetails!.add(new LanguageDetails.fromJson(v));
      });
    }
    profilePercentage = json['ProfilePercentage'];
    isVerified = json['isVerified'];
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
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['workStatus'] = this.workStatus;
    data['currentCity'] = this.currentCity;
    data['userProfilePhoto'] = this.userProfilePhoto;
    data['aboutUser'] = this.aboutUser;
    if (this.resumeDetails != null) {
      data['resumeDetails'] =
          this.resumeDetails!.map((v) => v.toJson()).toList();
    }
    if (this.employmentDetails != null) {
      data['employmentDetails'] =
          this.employmentDetails!.map((v) => v.toJson()).toList();
    }
    if (this.keySkillsDetails != null) {
      data['keySkillsDetails'] =
          this.keySkillsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.educationDetail != null) {
      data['educationDetail'] =
          this.educationDetail!.map((v) => v.toJson()).toList();
    }
    if (this.otherDetails != null) {
      data['otherDetails'] = this.otherDetails!.map((v) => v.toJson()).toList();
    }
    if (this.socialMediaDetails != null) {
      data['socialMediaDetails'] =
          this.socialMediaDetails!.map((v) => v.toJson()).toList();
    }
    if (this.coursesCertificateDetails != null) {
      data['coursesCertificateDetails'] =
          this.coursesCertificateDetails!.map((v) => v.toJson()).toList();
    }
    if (this.projectDetails != null) {
      data['projectDetails'] =
          this.projectDetails!.map((v) => v.toJson()).toList();
    }
    if (this.languageDetails != null) {
      data['languageDetails'] =
          this.languageDetails!.map((v) => v.toJson()).toList();
    }
    data['ProfilePercentage'] = this.profilePercentage;
    data['isVerified'] = this.isVerified;
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

class ResumeDetails {
  int? id;
  String? resumeFile;

  ResumeDetails({this.id, this.resumeFile});

  ResumeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resumeFile = json['resumeFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resumeFile'] = this.resumeFile;
    return data;
  }
}

class EmploymentDetails {
  int? id;
  IndustryTypeDetails? industryTypeDetails;
  RoleCategoryDetails? roleCategoryDetails;
  DepartmentTypeDetails? departmentTypeDetails;
  JobRoleDetails? jobRoleDetails;
  String? currentSalary;
  String? noticePeriod;
  bool? currentEmployed;
  String? totalWorkExperienced;
  String? companyName;
  String? currentJobTitle;
  String? currentCity;
  String? fromDuration;
  String? toDuration;

  EmploymentDetails(
      {this.id,
      this.industryTypeDetails,
      this.roleCategoryDetails,
      this.departmentTypeDetails,
      this.jobRoleDetails,
      this.currentSalary,
      this.noticePeriod,
      this.currentEmployed,
      this.totalWorkExperienced,
      this.companyName,
      this.currentJobTitle,
      this.currentCity,
      this.fromDuration,
      this.toDuration});

  EmploymentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    industryTypeDetails = json['industryTypeDetails'] != null
        ? new IndustryTypeDetails.fromJson(json['industryTypeDetails'])
        : null;
    roleCategoryDetails = json['roleCategoryDetails'] != null
        ? new RoleCategoryDetails.fromJson(json['roleCategoryDetails'])
        : null;
    departmentTypeDetails = json['departmentTypeDetails'] != null
        ? new DepartmentTypeDetails.fromJson(json['departmentTypeDetails'])
        : null;
    jobRoleDetails = json['jobRoleDetails'] != null
        ? new JobRoleDetails.fromJson(json['jobRoleDetails'])
        : null;
    currentSalary = json['currentSalary'];
    noticePeriod = json['noticePeriod'];
    currentEmployed = json['currentEmployed'];
    totalWorkExperienced = json['totalWorkExperienced'];
    companyName = json['companyName'];
    currentJobTitle = json['currentJobTitle'];
    currentCity = json['currentCity'];
    fromDuration = json['fromDuration'];
    toDuration = json['toDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.industryTypeDetails != null) {
      data['industryTypeDetails'] = this.industryTypeDetails!.toJson();
    }
    if (this.roleCategoryDetails != null) {
      data['roleCategoryDetails'] = this.roleCategoryDetails!.toJson();
    }
    if (this.departmentTypeDetails != null) {
      data['departmentTypeDetails'] = this.departmentTypeDetails!.toJson();
    }
    if (this.jobRoleDetails != null) {
      data['jobRoleDetails'] = this.jobRoleDetails!.toJson();
    }
    data['currentSalary'] = this.currentSalary;
    data['noticePeriod'] = this.noticePeriod;
    data['currentEmployed'] = this.currentEmployed;
    data['totalWorkExperienced'] = this.totalWorkExperienced;
    data['companyName'] = this.companyName;
    data['currentJobTitle'] = this.currentJobTitle;
    data['currentCity'] = this.currentCity;
    data['fromDuration'] = this.fromDuration;
    data['toDuration'] = this.toDuration;
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

class RoleCategoryDetails {
  int? id;
  String? categoryName;

  RoleCategoryDetails({this.id, this.categoryName});

  RoleCategoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    return data;
  }
}

class DepartmentTypeDetails {
  int? id;
  String? departmentName;

  DepartmentTypeDetails({this.id, this.departmentName});

  DepartmentTypeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentName = json['departmentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['departmentName'] = this.departmentName;
    return data;
  }
}

class JobRoleDetails {
  int? id;
  String? jobName;

  JobRoleDetails({this.id, this.jobName});

  JobRoleDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobName = json['jobName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobName'] = this.jobName;
    return data;
  }
}

class KeySkillsDetails {
  int? id;
  String? skillName;

  KeySkillsDetails({this.id, this.skillName});

  KeySkillsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skillName = json['skillName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['skillName'] = this.skillName;
    return data;
  }
}

class EducationDetail {
  int? id;
  EducationQualificationDetailsDetails? educationQualificationDetailsDetails;
  CourseDetails? courseDetails;
  CourseTypeDetails? courseTypeDetails;
  SpecificationDetails? specificationDetails;
  UniversityDetails? universityDetails;
  GradingSystemDetails? gradingSystemDetails;
  String? startingYear;
  String? marks;
  String? passingYear;

  EducationDetail(
      {this.id,
      this.educationQualificationDetailsDetails,
      this.courseDetails,
      this.courseTypeDetails,
      this.specificationDetails,
      this.universityDetails,
      this.gradingSystemDetails,
      this.startingYear,
      this.marks,
      this.passingYear});

  EducationDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    educationQualificationDetailsDetails =
        json['educationQualificationDetailsDetails'] != null
            ? new EducationQualificationDetailsDetails.fromJson(
                json['educationQualificationDetailsDetails'])
            : null;
    courseDetails = json['courseDetails'] != null
        ? new CourseDetails.fromJson(json['courseDetails'])
        : null;
    courseTypeDetails = json['courseTypeDetails'] != null
        ? new CourseTypeDetails.fromJson(json['courseTypeDetails'])
        : null;
    specificationDetails = json['specificationDetails'] != null
        ? new SpecificationDetails.fromJson(json['specificationDetails'])
        : null;
    universityDetails = json['universityDetails'] != null
        ? new UniversityDetails.fromJson(json['universityDetails'])
        : null;
    gradingSystemDetails = json['gradingSystemDetails'] != null
        ? new GradingSystemDetails.fromJson(json['gradingSystemDetails'])
        : null;
    startingYear = json['startingYear'];
    marks = json['marks'];
    passingYear = json['passingYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.educationQualificationDetailsDetails != null) {
      data['educationQualificationDetailsDetails'] =
          this.educationQualificationDetailsDetails!.toJson();
    }
    if (this.courseDetails != null) {
      data['courseDetails'] = this.courseDetails!.toJson();
    }
    if (this.courseTypeDetails != null) {
      data['courseTypeDetails'] = this.courseTypeDetails!.toJson();
    }
    if (this.specificationDetails != null) {
      data['specificationDetails'] = this.specificationDetails!.toJson();
    }
    if (this.universityDetails != null) {
      data['universityDetails'] = this.universityDetails!.toJson();
    }
    if (this.gradingSystemDetails != null) {
      data['gradingSystemDetails'] = this.gradingSystemDetails!.toJson();
    }
    data['startingYear'] = this.startingYear;
    data['marks'] = this.marks;
    data['passingYear'] = this.passingYear;
    return data;
  }
}

class EducationQualificationDetailsDetails {
  int? id;
  String? qualificationName;

  EducationQualificationDetailsDetails({this.id, this.qualificationName});

  EducationQualificationDetailsDetails.fromJson(Map<String, dynamic> json) {
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

class CourseTypeDetails {
  int? id;
  String? courseTypeName;

  CourseTypeDetails({this.id, this.courseTypeName});

  CourseTypeDetails.fromJson(Map<String, dynamic> json) {
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

class SpecificationDetails {
  int? id;
  String? specificationName;

  SpecificationDetails({this.id, this.specificationName});

  SpecificationDetails.fromJson(Map<String, dynamic> json) {
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

class UniversityDetails {
  int? id;
  String? universityName;

  UniversityDetails({this.id, this.universityName});

  UniversityDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    universityName = json['universityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['universityName'] = this.universityName;
    return data;
  }
}

class GradingSystemDetails {
  int? id;
  String? name;

  GradingSystemDetails({this.id, this.name});

  GradingSystemDetails.fromJson(Map<String, dynamic> json) {
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

class OtherDetails {
  int? id;
  String? resumeHeadline;
  String? preferredWorkLocation;
  String? preferredSalary;
  String? gender;

  OtherDetails(
      {this.id,
      this.resumeHeadline,
      this.preferredWorkLocation,
      this.preferredSalary,
      this.gender});

  OtherDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resumeHeadline = json['resumeHeadline'];
    preferredWorkLocation = json['preferredWorkLocation'];
    preferredSalary = json['preferredSalary'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resumeHeadline'] = this.resumeHeadline;
    data['preferredWorkLocation'] = this.preferredWorkLocation;
    data['preferredSalary'] = this.preferredSalary;
    data['gender'] = this.gender;
    return data;
  }
}

class SocialMediaDetails {
  int? id;
  String? linkedin;
  String? github;
  String? facebook;
  String? instagram;
  String? twitter;

  SocialMediaDetails(
      {this.id,
      this.linkedin,
      this.github,
      this.facebook,
      this.instagram,
      this.twitter});

  SocialMediaDetails.fromJson(Map<String, dynamic> json) {
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

class CoursesCertificateDetails {
  int? id;
  String? certificateName;
  String? certificateUrl;
  String? issueBy;
  bool? isExpiryTime;
  String? expiryDate;
  String? certificateImage;

  CoursesCertificateDetails(
      {this.id,
      this.certificateName,
      this.certificateUrl,
      this.issueBy,
      this.isExpiryTime,
      this.expiryDate,
      this.certificateImage});

  CoursesCertificateDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    certificateName = json['certificateName'];
    certificateUrl = json['certificateUrl'];
    issueBy = json['issueBy'];
    isExpiryTime = json['isExpiryTime'];
    expiryDate = json['expiryDate'];
    certificateImage = json['certificateImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['certificateName'] = this.certificateName;
    data['certificateUrl'] = this.certificateUrl;
    data['issueBy'] = this.issueBy;
    data['isExpiryTime'] = this.isExpiryTime;
    data['expiryDate'] = this.expiryDate;
    data['certificateImage'] = this.certificateImage;
    return data;
  }
}

class ProjectDetails {
  int? id;
  String? name;
  String? url;
  String? description;
  String? status;
  String? startDate;
  String? endDate;

  ProjectDetails(
      {this.id,
      this.name,
      this.url,
      this.description,
      this.status,
      this.startDate,
      this.endDate});

  ProjectDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    description = json['description'];
    status = json['status'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['description'] = this.description;
    data['status'] = this.status;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}

class LanguageDetails {
  int? id;
  String? language;
  String? proficiency;

  LanguageDetails({this.id, this.language, this.proficiency});

  LanguageDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    proficiency = json['proficiency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language'] = this.language;
    data['proficiency'] = this.proficiency;
    return data;
  }
}
