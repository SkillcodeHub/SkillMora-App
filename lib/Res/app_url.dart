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

  // static var baseUrl = "https://4250-2402-3a80-1ea9-7086-7d24-197d-14ce-9a4b.ngrok-free.app";

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
  static var companydetailbyIdUrl = baseUrl + '/company/companydetailbycompanyid';
  // notification List Url
  static var notificationListUrl = baseUrl + '/user/getusernotifications';
  
  // add company reviews Url
  static var addcompanyreviewsUrl = baseUrl + '/company/addcompanyreviews';



  
}
