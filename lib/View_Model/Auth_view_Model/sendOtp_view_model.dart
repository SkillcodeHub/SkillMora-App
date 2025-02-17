import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Repository/Auth_Repository/sendOtp_repository.dart';
import '../../Res/colors.dart';
import '../../View/OtpVerify/otpVerifyScreen.dart';

class SendOtpViewModel with ChangeNotifier {
  final _myRepo = SendOtpRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> sendOtpApi(dynamic data, BuildContext context) async {

    print('data');
    setLoading(true);
    await _myRepo.sendOtpapi(data).then((value) {
      if (value['status'] == true) {
        Map data1 = {
          'email': data['email'].toString(),
        };
        setLoading(false);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpVerificationScreen(
                      data: data,
                    )));

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
