import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:skillmoraskh_app/View_Model/Jobs_View_Model/applyJob_view_model.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/ProjectDetails_View_Model/addProjectDetails_view_model.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/ProjectDetails_View_Model/editProjectDetails_view_model.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/WorkExperience_View_Model/addWorkExperience_view_model.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/WorkExperience_View_Model/departmentTypeList_view_model.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/WorkExperience_View_Model/editWorkExperience_view_model.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/WorkExperience_View_Model/industryTypeList_view_model.dart';
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
import 'View_Model/Profile_View_Model/EditOtherDetails_View_Model/editOtherDetails_view_model.dart';
import 'View_Model/Profile_View_Model/EditUserAboutInfo/editUserAboutInfo_view_model.dart';
import 'View_Model/Profile_View_Model/EditUserProfileDetails/editUserProfileDetails_view_model.dart';
import 'View_Model/Profile_View_Model/GetProfileDetails/profile_view_model.dart';
import 'View_Model/Profile_View_Model/GetSkill_View_Model/getSkill_View_Model.dart';
import 'View_Model/Profile_View_Model/UpdateKeySkill_View_Model/updateKeySkill_View_Model.dart';
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
        ChangeNotifierProvider(create: (_) => EditUserAboutInfoViewModel()),
        ChangeNotifierProvider(create: (_) => EditOtherDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => UpdateKeySkillViewModel()),
        ChangeNotifierProvider(create: (_) => AddWorkExperienceViewModel()),
        ChangeNotifierProvider(create: (_) => EditWorkExperienceViewModel()),
        ChangeNotifierProvider(create: (_) => AddProjectDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => EditProjectDetailsViewModel()),
        ChangeNotifierProvider(
            create: (_) => EditUserProfileDetailsViewModel()),
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
        ChangeNotifierProvider<ProfileDetailsViewmodel>.value(
            value: ProfileDetailsViewmodel()),
        ChangeNotifierProvider<GetSkillListViewmodel>.value(
            value: GetSkillListViewmodel()),
        ChangeNotifierProvider<DepartmentTypeListViewModel>.value(
            value: DepartmentTypeListViewModel()),
        ChangeNotifierProvider<IndustryTypeListViewModel>.value(
            value: IndustryTypeListViewModel()),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        return Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Skill Mora',
              // theme: AppTheme.lightTheme,
              initialRoute: RoutesName.splash,
              onGenerateRoute: Routes.generateRoute,
            );
          },
        );
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
