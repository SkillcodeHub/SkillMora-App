import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Repository/AddReview_Repository/addReview_repository.dart';
import '../../View/NavigationBar/navigationBar.dart';

class AddReviewViewModel with ChangeNotifier {

  final _myRepo = AddReviewRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }


  Future<void> AddReviewApi(String ipAddress, String token, Map<String, String> data,
       BuildContext context) async {


    setLoading(true);
    try {
      final value = await _myRepo.addReviewApi(ipAddress,token, data);

      if (value['status'] == true) {
        Navigator.pop(context, true);
        setLoading(false);
        if (kDebugMode) {
          print(value.toString());
        }


        Navigator.push(context, MaterialPageRoute(builder: (context)=> MyNavigationBar(indexNumber: 0,)));
      } else if (value['status'] == false) {
        setLoading(false);

        if (kDebugMode) {
          print(value.toString());
        }
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'Aleart',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
              ),
              content: Text(
                value['message'].toString(),
                style: TextStyle(
                    // fontWeight:
                    //     FontWeight
                    //         .bold,
                    fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                SizedBox(
                  width: 80.w,
                  child: ElevatedButton(
                    child: Text(
                      'OK',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      setLoading(false);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Aleart !',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),
            content: Text(
              error.toString(),
              style: TextStyle(
                  // fontWeight:
                  //     FontWeight
                  //         .bold,
                  fontSize: 12.sp),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              SizedBox(
                width: 80.w,
                child: ElevatedButton(
                  child: Text(
                    'OK',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        },
      );
    }
    ;
  }
}
