import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../SharedPreferences/sharePreference.dart';
import '../../View_Model/Auth_view_Model/login_view_model.dart';
import '../Login/loginScreen.dart';
import '../NavigationBar/navigationBar.dart';

class SplashServices {
  var token;
  var userEFAW;
  UserPreferences userPreference = UserPreferences();

  void checkAuthentication(BuildContext context) async {
    userPreference.getToken().then((value) async {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

      token = value;
      print('mobilemobilemobilemobilemobilemobile');
      print(token);
      print('lllllll${authViewModel.signUpLoading.toString()}');
      userPreference.getUserEFAW().then((value) {
        userEFAW = value;
        print('userEFAWuserEFAWuserEFAWuserEFAWuserEFAWuserEFAW');
        print(userEFAW);
        print('lllllll${authViewModel.signUpLoading.toString()}');

        if (token == 'null' || token == null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false);
        } else if (token != 'null' || userEFAW != null) {
          // if (userEFAW == 'true') {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => MyNavigationBar(
                          indexNumber: 0,
                        )),
                (route) => false);
          // }
        }
      });
    })
        // })

        .onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
