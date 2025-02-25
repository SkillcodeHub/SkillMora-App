import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:skillmoraskh_app/View_Model/Auth_view_Model/registerUser_view_model.dart';
import '../../Repository/Auth_Repository/verifyOtp_repository.dart';
import '../../Res/colors.dart';
import '../../Utils/date_utils.dart';
import '../../View/Login/loginScreen.dart';
import '../../View/OtpVerify/otpVerifyScreen.dart';

class VerifyOtpViewModel with ChangeNotifier {
  final _myRepo = VerifyOtpRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> verifyOtpApi(dynamic data, BuildContext context) async {
    setLoading(true);
    await _myRepo.verifyOtpapi(data).then((value) {
      if (value['status'] == true) {
        Utils.snackBar(value['message'], context);

            final registerViewModel = Provider.of<RegisterViewModel>(context,listen: false);
          setLoading(false);

                                registerViewModel.registerUserApi(
                                    data, context);
        // Timer(Duration(seconds: 2), () {
        //   // Navigator.push(
        //   //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
        // });

        if (kDebugMode) {
          print(value.toString());
        }
      } else if (value['status'] == false) {
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
                  value['message'].toString(),
                  style: TextStyle(fontSize: 12.sp),
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
                style: TextStyle(fontSize: 12.sp),
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
}
