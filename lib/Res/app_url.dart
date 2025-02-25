class AppUrl {
  //Base Url
  // http://localhost:6000/api/
  // static var baseUrl = "http://10.0.2.2:6000/api/";

  // static var baseUrl = "https://www.axonweb.in//";
  // static var baseUrl = "http://18.188.250.51:7000/api/cms/";
  // static var baseUrl1 = "http://18.188.250.51:8000/apapii/axonWeb/";
  // static var baseUrl = "http://10.0.2.2:7000/api/cms/";
  // static var baseUrl1 = "http://10.0.2.2:8000/api/axonWeb/";
  // static var baseUrl = "http://192.168.1.5:7000/api/cms/";
  // static var baseUrl1 = "http://192.168.1.5:8000/api/axonWeb/";

  static var baseUrl = "https://api.skillmora.com";

  // static var baseUrl = "https://4c11-2402-a00-152-d6b7-87d2-dde3-ccbe-f382.ngrok-free.app";

  // login Url
  static var loginUrl = baseUrl + '/user/userlogin?clientId=1&ipAddress=null';

  // user Register Url
  static var userRegisterUrl =
      baseUrl + '/user/userregister?clientId=1&ipAddress=null';

  // upload Resume Url
  static var uploadResumeUrl =
      baseUrl + '/admin1/upload?clientId=1&ipAddress=null';

  // send Otp Url
  static var sendOtpUrl =
      baseUrl + '/user/usersendotp?clientId=1&ipAddress=null';

  // verify Otp Url
  static var verifyOtpUrl =
      baseUrl + '/user/userverifyotp?clientId=1&ipAddress=null';

  // verify Otp Url
  static var filterJobsListUrl = baseUrl + '/company/filterjobs';

  // saved Jobs List Url
  static var savedJobsListUrl = baseUrl + '/user/getusersavedjobs';

  // applied Jobs List Url
  static var appliedJobsListUrl = baseUrl + '/user/getuserappliedjobs';

  // applied Jobs List Url
  static var applyjobsUrl = baseUrl + '/user/applyjob';

  // company detail by Id Url
  static var companydetailbyIdUrl =
      baseUrl + '/company/companydetailbycompanyid';
  // notification List Url
  static var notificationListUrl = baseUrl + '/user/getusernotifications';

  // add company reviews Url
  static var addcompanyreviewsUrl = baseUrl + '/company/addcompanyreviews';

  // edit user profile Url
  static var edituserprofileUrl = baseUrl + '/user/edituserprofile';

  //user profile Url
  static var userprofileUrl = baseUrl + '/user/user';

  //edit user about info Url
  static var edituseraboutinfoUrl = baseUrl + '/user/edituseraboutinfo';

  //edit user about info Url
  static var editOtherDetailsUrl = baseUrl + '/user/edituserotherdetails';

  //edit user about info Url
  static var getSkillListUrl = baseUrl + '/admin1/keyskills';

  //update user key skill Url
  static var updateuserkeyskillUrl = baseUrl + '/user/updateuserkeyskill';

  //add Work Experience Url
  static var addWorkExperienceUrl = baseUrl + '/user/adduseremployment';

  //edit Work Experience Url
  static var editWorkExperienceUrl = baseUrl + '/user/edituseremployment';

  //add Project Details Url
  static var addProjectDetailsUrl = baseUrl + '/user/adduserproject';

  //edit Project Details Url
  static var editProjectDetailsUrl = baseUrl + '/user/edituserproject';

  //industry type Url
  static var industrytypeListUrl = baseUrl + '/admin1/industrytype';

  //department type List Url
  static var departmenttypeListUrl = baseUrl + '/admin1/departmenttype';
}
