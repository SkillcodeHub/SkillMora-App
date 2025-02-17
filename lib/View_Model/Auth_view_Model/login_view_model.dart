import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Repository/Auth_Repository/login_repository.dart';
import '../../Res/colors.dart';
import '../../SharedPreferences/sharePreference.dart';
import '../../Utils/date_utils.dart';
import '../../View/NavigationBar/navigationBar.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  String maskEmail(String? email) {
    if (email == null) return ''; // Return an empty string if the email is null

    // Split the email into parts (username and domain)
    final parts = email.split('@');
    if (parts.length != 2)
      return email; // Return the email as-is if it's invalid

    final username = parts[0];
    final domain = parts[1];

    // Check if the username is long enough to mask
    if (username.length <= 4) {
      return email; // Return the email as-is if the username is too short to mask
    }

    // Mask the username
    final maskedUsername = username.substring(0, 2) +
        '*' * (username.length - 4) +
        username.substring(username.length - 2);

    // Mask the domain
    final domainParts = domain.split('.');
    if (domainParts.length < 2) return '$maskedUsername@${'*' * domain.length}';

    final mainDomain = domainParts[0];
    final domainExtension = domainParts[1];

    // Show the first letter of the main domain, mask the rest, and partially mask the extension
    final maskedMainDomain = mainDomain[0] + '*' * (mainDomain.length - 1);
    final maskedDomainExtension = '*' * (domainExtension.length - 2) +
        domainExtension.substring(domainExtension.length - 2);

    return '$maskedUsername@$maskedMainDomain.$maskedDomainExtension';
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    await _myRepo.loginapi(data).then((value) {
      UserPreferences userPreference = UserPreferences();

      if (value['status'] == true) {
        setLoading(false);

        print(
            'value value value value value value value value value value value value value value value value value ');
        print(value['refresh']);
        Map<String, dynamic> userData = {
          "user": {
            "id": value['user']['id'].toString(),
            "name": value['user']['name'].toString(),
            "email": value['user']['email'].toString(),
            "mobile": value['user']['mobile'].toString(),
            "workStatus": value['user']['workStatus'].toString(),
            "currentCity": value['user']['currentCity'].toString(),
            "isVerified": value['user']['isVerified'].toString(),
            "isBlackListed": value['user']['isBlackListed'].toString(),
            "userProfilePhoto": value['user']['userProfilePhoto'].toString(),
            "aboutUser": value['user']['aboutUser'].toString(),
            "created_at": value['user']['created_at'].toString(),
            "updated_at": value['user']['updated_at'].toString(),
            "created_by": value['user']['created_by'].toString(),
            "updated_by": value['user']['updated_by'].toString(),
            "isDelete": value['user']['isDelete'].toString(),
            "clientId": value['user']['clientId'].toString(),
            "client_id": value['user']['client_id'].toString(),
            "client_name": value['user']['client_name'].toString(),
            "company_name": value['user']['company_name'].toString(),
          },
          "client": {
            "client_id": value['client']['client_id'].toString(),
            "client_name": value['client']['client_name'].toString(),
            "company_name": value['client']['company_name'].toString(),
            "client_gstNo": value['client']['client_gstNo'].toString(),
            "client_address": value['client']['client_address'].toString(),
          },
          "refresh": value['refresh'].toString(),
          "access": value['access'].toString(),
        };

        print(
            'value value value value value value value value value value value value value value value value value ');
        // Utils.flushBarErrorMessage(
        //     "OTP Send Successfully", Duration(seconds: 2), context);
                 userPreference.saveUserData(userData);

        userPreference.setToken(value['refresh']);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyNavigationBar(indexNumber: 0)));
        // Timer(Duration(seconds: 2), () {
        // });

        if (kDebugMode) {
          print(value.toString());
        }
      } else if (value['status'] == false) {
        // Utils.snackBar('OTP Send Successfully', context);

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Container(
                  child: AlertDialog(
                title: Center(
                  child: Text(
                    'Alert!',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                content: Text(
                  'Please enter a valid number',
                  style: TextStyle(
                      // fontWeight:
                      //     FontWeight
                      //         .bold,
                      fontSize: 12.sp),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 3.h),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: appPrimaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          width: 60.w,
                          child: Center(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                                // fontWeight:
                                //     FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ));
            });
      }
      ;
    }).onError((error, stackTrace) {
      print(error.toString());
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Container(
                child: AlertDialog(
              title: Center(
                child: Text(
                  'Alert!',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
              ),
              content: Text(
                error.toString(),
                // 'AxonPro is currently down. Please try after sometime.',
                style: TextStyle(
                    // fontWeight:
                    //     FontWeight
                    //         .bold,
                    fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.h),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: appPrimaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        width: 60.w,
                        child: Center(
                          child: Text(
                            'OK',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                              // fontWeight:
                              //     FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ));
          });

      // Utils.snackBar(error.toString(), context);
      setLoading(false);

      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> resendOTPApi(dynamic data, BuildContext context) async {
    setLoading(true);
    await _myRepo.loginapi(data).then((value) {
      if (value['status'] == true) {
        Utils.flushBarErrorMessage(
            "OTP Send Successfully", Duration(seconds: 2), context);
        setLoading(false);

        if (kDebugMode) {
          print(value.toString());
        }
      }
    }).onError((error, stackTrace) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Container(
                child: AlertDialog(
              title: Center(
                child: Text(
                  'Alert!',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
              ),
              content: Text(
                'AxonPro is currently down. Please try after sometime.',
                style: TextStyle(
                    // fontWeight:
                    //     FontWeight
                    //         .bold,
                    fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 3.h),
                    InkWell(
                      onTap: () {
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => LogoutMessageScreen()),
                        //     (route) => false);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: appPrimaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        width: 60.w,
                        child: Center(
                          child: Text(
                            'OK',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                              // fontWeight:
                              //     FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ));
          });
      setLoading(false);

      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  // Future<void> otpVerifyApi(dynamic data, BuildContext context) async {
  //   setSignUpLoading(true);
  //   UserPreferences userPreference = UserPreferences();

  //   try {
  //     final response = await _myRepo.otpverifyapi({
  //       "Mobile": data['Mobile'].toString(),
  //       'OTP': data['OTP'].toString(),
  //       "deviceId": data['deviceId'].toString(),
  //       "fcmToken": data['fcmToken'].toString(),
  //       "userType": data['userType'].toString(),
  //     });

  //     if (response['status'] == true) {
  //       // Save user data
  //       Map<String, dynamic> userData = {
  //         "data": {
  //           "userData": {
  //             "SRNo": response['data']['userData']['SRNo'].toString(),
  //             "DrNAME":
  //                 "${response['data']['userData']['Title']} ${response['data']['userData']['NAME']}",
  //             "ClinicName":
  //                 response['data']['userData']['ClinicName'].toString(),
  //             "ClinicAddr":
  //                 response['data']['userData']['ClinicAddr'].toString(),
  //             "Pin": response['data']['userData']['Pin'].toString(),
  //             "ClinicNo": response['data']['userData']['ClinicNo'].toString(),
  //             "Mobile": response['data']['userData']['Mobile'].toString(),
  //             "Email": response['data']['userData']['Email'].toString(),
  //             "SoftwareID":
  //                 response['data']['userData']['SoftwareID'].toString(),
  //             "amcduedate":
  //                 response['data']['userData']['amcduedate'].toString(),
  //             "deviceId": data['deviceId'].toString(),
  //             "fcmToken": data['fcmToken'].toString(),
  //           },
  //           "isAxonWebSubscribed":
  //               response['data']['isAxonWebSubscribed'].toString(),
  //           "cmsToken": response['data']['cmsToken'].toString(),
  //           "axonToken": response['data']['axonToken'].toString(),
  //           "UserID": response['data']['UserID'].toString(),
  //           "usertype": response['data']['usertype'].toString(),
  //         }
  //       };

  //       // Save permissions
  //       List<dynamic> permissions = [];
  //       if (response['data']['permisionData'] != null) {
  //         if (response['data']['permisionData']['cmsPermissionsArr'] != null) {
  //           permissions
  //               .addAll(response['data']['permisionData']['cmsPermissionsArr']);
  //         }
  //         if (response['data']['permisionData']['axonwebPermissionArr'] !=
  //             null) {
  //           permissions.addAll(
  //               response['data']['permisionData']['axonwebPermissionArr']);
  //         }
  //       }

  //       // Save data to SharedPreferences
  //       await userPreference.saveUserData(userData);
  //       await userPreference.savePermissions(permissions);
  //       await userPreference.setMobile(data['Mobile']);
  //       await userPreference.setUserEFAW('true');

  //       // Navigate based on subscription status
  //       if (response['data']['isAxonWebSubscribed'] == true) {
  //         // Navigator.pushAndRemoveUntil(
  //         //     context,
  //         //     MaterialPageRoute(builder: (context) => NRoleSelectionScreen()),
  //         //     (route) => false);
  //       } else {
  //         // Navigator.pushAndRemoveUntil(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //         builder: (context) => CmsMyNavigationBar(indexNumber: 0)),
  //         //     (route) => false);
  //       }
  //     } else {
  //       Utils.snackBar(response['message'], context);
  //     }
  //   } catch (error) {
  //             showDialog(
  //           barrierDismissible: false,
  //           context: context,
  //           builder: (context) {
  //             return Container(
  //                 child: AlertDialog(
  //               title: Center(
  //                 child: Text(
  //                   'Alert!',
  //                   style:
  //                       TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               content: Text(
  //                 'AxonPro is currently down. Please try after sometime.',
  //                 style: TextStyle(
  //                     // fontWeight:
  //                     //     FontWeight
  //                     //         .bold,
  //                     fontSize: 12.sp),
  //                 textAlign: TextAlign.center,
  //               ),
  //               actions: <Widget>[
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     SizedBox(height: 3.h),
  //                     InkWell(
  //                       onTap: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: Container(
  //                         padding: EdgeInsets.all(8),
  //                         decoration: BoxDecoration(
  //                             color: appPrimaryColor,
  //                             borderRadius: BorderRadius.circular(15)),
  //                         width: 60.w,
  //                         child: Center(
  //                           child: Text(
  //                             'OK',
  //                             style: TextStyle(
  //                               fontSize: 13.sp,
  //                               color: Colors.white,
  //                               // fontWeight:
  //                               //     FontWeight.bold,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ));
  //           });
  //        if (kDebugMode) {
  //       print(error.toString());
  //     }
  //   } finally {
  //     setSignUpLoading(false);
  //   }
  // }
}
