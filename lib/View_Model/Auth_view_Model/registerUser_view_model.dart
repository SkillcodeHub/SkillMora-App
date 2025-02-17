import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Repository/Auth_Repository/register_repository.dart';
import '../../Res/colors.dart';
import '../../View/Login/loginScreen.dart';

class RegisterViewModel with ChangeNotifier {
  final _myRepo = RegisterRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> registerUserApi(dynamic data, BuildContext context) async {
    setLoading(true);
    await _myRepo.registerUserapi(data).then((value) {
      if (value['status'] == true) {

          setLoading(false);


           Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        // Timer(Duration(seconds: 2), () {



        // });

        if (kDebugMode) {
          print(value.toString());
        }
      } else if (value['status'] == false) {
        final registerViewModel =
            Provider.of<RegisterViewModel>(context, listen: false);
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
                          registerViewModel.setLoading(false);
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
                style: TextStyle(
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
