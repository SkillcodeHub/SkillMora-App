import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:skillmoraapp/View_Model/Jobs_View_Model/applyJob_view_model.dart';
import 'Utils/Routes/routes.dart';
import 'Utils/Routes/routes_name.dart';
import 'View_Model/Jobs_View_Model/appliedJobs_view_model.dart';
import 'View_Model/Jobs_View_Model/companyDetailsById_view_model.dart';
import 'View_Model/Jobs_View_Model/filterjobs_view_model.dart';
import 'View_Model/Auth_view_Model/login_view_model.dart';
import 'View_Model/Auth_view_Model/registerUser_view_model.dart';
import 'View_Model/Auth_view_Model/sendOtp_view_model.dart';
import 'View_Model/Auth_view_Model/verifyOtp_view_model.dart';
import 'View_Model/Jobs_View_Model/savedJobs_view_model.dart';
import 'View_Model/Notification_View_Model/notificationList_view_model.dart';
import 'View_Model/Review_View_Model/addReview_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => SendOtpViewModel()),
        ChangeNotifierProvider(create: (_) => VerifyOtpViewModel()),
        ChangeNotifierProvider(create: (_) => ApplyJobViewModel()),
        ChangeNotifierProvider(create: (_) => AddReviewViewModel()),

        

                    ChangeNotifierProvider<FilterJobsViewmodel>.value(
            value: FilterJobsViewmodel()),

        ChangeNotifierProvider<GetAppliedJobsListViewmodel>.value(
            value: GetAppliedJobsListViewmodel()),
        ChangeNotifierProvider<GetSavedJobsListViewmodel>.value(
            value: GetSavedJobsListViewmodel()),
        ChangeNotifierProvider<CompanyDetailsByIdViewmodel>.value(
            value: CompanyDetailsByIdViewmodel()),
        ChangeNotifierProvider<NotificationListViewmodel>.value(
            value: NotificationListViewmodel()),


            
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        return Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Axon Doctor',
              // theme: AppTheme.lightTheme,
              initialRoute: RoutesName.splash,
              onGenerateRoute: Routes.generateRoute,
            );
          },
        );
        ;
      }),
    );
  }
}




//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home:  OnboardingScreen(),
//     );
//   }
// }
