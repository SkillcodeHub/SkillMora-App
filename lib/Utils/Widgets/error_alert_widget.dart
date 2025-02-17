import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class ErrorScreenWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final String loadingText;

  ErrorScreenWidget({
    required this.onRefresh,
    required this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                height: 74.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 22.h),
                    Center(
                      child: Image.asset(
                        'images/loading.png',
                        height: 20.h,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Center(
                      child: Text(
                        loadingText,
                        style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? 14.sp
                              : 12.sp,
                          fontWeight: FontWeight.w500,
                          
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlertWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final String loadingText;
  final String? statusCode;

  AlertWidget({
    required this.onRefresh,
    required this.loadingText,
    this.statusCode,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              height: 74.h,
              child: Center(
                child: AlertDialog(
                  title: Center(
                    child: Text(
                      'Alert!',
                      style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  content: Text(

                    
  statusCode == "400"
      ? "Please check your input and try again."
      : statusCode == "401"
          ? "It looks like you don't have permission to access this. Contact support if you think this is a mistake."
          : statusCode == "403"
              ? loadingText
              : statusCode == "404"
                  ? "Oops! Something went wrong. Please try again."
                  : statusCode == "500"
                      ? "We're experiencing technical difficulties. Our team is on it!"
                      : 
                      "Hmm, something's not quite right. Please try again or contact support.",
                      
                  // loadingText    ,
  style: TextStyle(fontSize: 14.sp),
  textAlign: TextAlign.center,
),

                  // content: Text(
                  //  statusCode == "403" ? loadingText : "something went wrong",
                  //   style: TextStyle(fontSize: 14.sp),
                  //   textAlign: TextAlign.center,
                  // ),
                  actions: <Widget>[
                    SizedBox(
                      width: 80.w,
                      child: ElevatedButton(
                        child: Text(
                         statusCode == "403"
              ? 'Subscribe Now':'OK',
                          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (statusCode == "403") {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => AxonWebPurchaseScreen()));
                          } else {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => CmsMyNavigationBar(indexNumber: 0)));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NotifyMessageWidget extends StatelessWidget {
  final String loadingText;

  NotifyMessageWidget({
    required this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              height: 74.h,
              child: Center(
                child: AlertDialog(
                  title: Center(
                    child: Text(
                      'Alert!',
                      style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  content: Text(

                    
                     loadingText,
                      
                  // loadingText    ,
  style: TextStyle(fontSize: 14.sp),
  textAlign: TextAlign.center,
),

                  // content: Text(
                  //  statusCode == "403" ? loadingText : "something went wrong",
                  //   style: TextStyle(fontSize: 14.sp),
                  //   textAlign: TextAlign.center,
                  // ),
                  actions: <Widget>[
              //       SizedBox(
              //         width: 80.w,
              //         child: ElevatedButton(
              //           child: Text(
              //            statusCode == "403"
              // ? 'Subscribe Now':'OK',
              //             style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              //           ),
              //           onPressed: () {
              //             if (statusCode == "403") {
              //               Navigator.push(context, MaterialPageRoute(builder: (context) => AxonWebPurchaseScreen()));
              //             } else {
              //               Navigator.push(context, MaterialPageRoute(builder: (context) => CmsMyNavigationBar(indexNumber: 0)));
              //             }
              //           },
              //         ),
              //       ),
                 
                 
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class ErrorHandlerUtility {
  static Widget handleError({
    required String errorMessage,
    required Function refresh,
    required BuildContext context,
  }) {
    if (errorMessage == "No Internet Connection") {
      return ErrorScreenWidget(
        onRefresh: () async => refresh(),
        // loadingText: errorMessage,
        loadingText:"Looks like you’re offline. Check your connection and try again."
      );
    }  else if (errorMessage == "You do not have permission to access this feature.") {
      return NotifyMessageWidget(
        loadingText:"You do not have permission to access this feature."
      );
    } 
    
    
    
    
    
    else {
      Map<String, dynamic> errorData = _parseErrorMessage(errorMessage);

      print(errorData['message']);
            print(errorData['code']);

      return AlertWidget(
        onRefresh: () async => refresh(),
        loadingText: errorData['message'] ?? 'Unknown error occurred',
        statusCode: errorData['code']?.toString() ?? '',
      );
    }
  }

  static Map<String, dynamic> _parseErrorMessage(String errorMessage) {
    try {
      int startIndex = errorMessage.indexOf('{');
      int endIndex = errorMessage.lastIndexOf('}');
      
      if (startIndex != -1 && endIndex != -1) {
        String jsonSubstring = errorMessage.substring(startIndex, endIndex + 1);
        return json.decode(jsonSubstring);
      }
    } catch (e) {
      print('Error parsing error message: $e');
    }
    
    // If parsing fails, return a default structure
    return {
      'message': errorMessage,
      'code': '',
    };
  }
}
