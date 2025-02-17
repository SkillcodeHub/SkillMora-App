import 'package:flutter/material.dart';
import 'package:skillmoraapp/Utils/Routes/routes_name.dart';

import '../../View/Jobs/JobsScreen.dart';
import '../../View/Jobs/applyJobScreen.dart';
import '../../View/Jobs/jobDetailsScreen.dart';
import '../../View/Login/loginScreen.dart';
import '../../View/NavigationBar/navigationBar.dart';
import '../../View/OtpVerify/otpVerifyScreen.dart';
import '../../View/Registration/registration_screen.dart';
import '../../View/Review/reviewScreen.dart';
import '../../View/Splash/splashScreen.dart';
import '../../onBoardingScreen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => OnboardingScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());
      case RoutesName.verifyOtp:
        return MaterialPageRoute(
            builder: (BuildContext context) => OtpVerificationScreen(data: settings.arguments as Map));
      case RoutesName.registerUser:
        return MaterialPageRoute(
            builder: (BuildContext context) => SkillmoraRegistration());
      case RoutesName.myNevigationBar:
        return MaterialPageRoute(
            builder: (BuildContext context) => MyNavigationBar(indexNumber: 0,));
      case RoutesName.jobScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => JobsScreen());
      case RoutesName.JobDetails:
        return MaterialPageRoute(
            builder: (BuildContext context) => JobDetailsScreen(data: settings.arguments as Map));
      case RoutesName.applyJobScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ApplyJobScreen(data: settings.arguments as Map));
                  case RoutesName.addReviewScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddReviewScreen(data: settings.arguments as Map));



      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
