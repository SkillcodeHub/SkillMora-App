
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skillmoraskh_app/Repository/Profile_Repository/ProjectDetails_Repository/addProjectDetails_repository.dart';
import 'package:skillmoraskh_app/View/NavigationBar/navigationBar.dart';



class AddProjectDetailsViewModel with ChangeNotifier {
  final _myRepo = AddProjectDetailsRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addProjectDetailsApi(String ipAddress, String token,
      Map<String, String> data, BuildContext context) async {
    setLoading(true);
    try {
      final value = await _myRepo.addProjectDetailsApi(ipAddress, token, data);

      if (value['status'] == true) {
        // Navigator.pop(context, true);
        setLoading(false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyNavigationBar(indexNumber: 3),
          ),
        );

        if (kDebugMode) {
          print(value.toString());
        }

        if (kDebugMode) {
          print(value.toString());
        }
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
 