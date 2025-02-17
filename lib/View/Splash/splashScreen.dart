
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skillmoraapp/View/Splash/splashServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splasheSrvices = SplashServices();

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 1),
      () {
    splasheSrvices.checkAuthentication(context);
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  // child: Container(
                  //   height: 15.h,
                  //   child: Image.asset(
                  //     'images/axon.png',
                  //   ),
                  // ),
                  // Text(
                  //   "Axon",
                  //   style: Theme.of(context).textTheme.headline2,
                  // ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Access all your doctor-related needs in one place with AXON',
                    style: TextStyle(fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
 ;
  }
}
