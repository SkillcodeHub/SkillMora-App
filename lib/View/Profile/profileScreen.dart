import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:skillmoraskh_app/View/Login/loginScreen.dart';
import 'package:skillmoraskh_app/View/Profile/addProjectScreen.dart';
import 'package:skillmoraskh_app/View/Profile/addWorkExprienceScreen.dart';
import 'package:skillmoraskh_app/View/ProfileDetails/additionalDetailsScreen.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/GetProfileDetails/profile_view_model.dart';
import '../../Data/Response/status.dart';
import '../../Models/ProfileDetails_Model/profileDetails_model.dart';
import '../../SharedPreferences/sharePreference.dart';
import '../../View_Model/Profile_View_Model/EditOtherDetails_View_Model/editOtherDetails_view_model.dart';
import '../../View_Model/Profile_View_Model/EditUserAboutInfo/editUserAboutInfo_view_model.dart';
import '../../View_Model/Profile_View_Model/EditUserProfileDetails/editUserProfileDetails_view_model.dart';
import '../../View_Model/Profile_View_Model/GetSkill_View_Model/getSkill_View_Model.dart';
import '../../View_Model/Profile_View_Model/UpdateKeySkill_View_Model/updateKeySkill_View_Model.dart';

// class ProfileScreen extends StatefulWidget {
//   ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   late Future<void> fetchDataFuture;
//   String ipAddress = '103.241.225.195';
//   String? token;
//   UserPreferences userPreference = UserPreferences();
//   dynamic UserData1;
//   String? profileLogo;
//   String? name;
//   String? email;
//   String? mobile;
//   String? workStatus;
//   String? currentCity;
//   String? aboutUser;

//   @override
//   void initState() {
//     userPreference.getUserData().then((value) {
//       setState(() {
//         UserData1 = value!;
//         token = UserData1['refresh'].toString();
//         // profileLogo = UserData1['user']['userProfilePhoto'].toString();
//         // name = UserData1['user']['name'].toString();
//         email = UserData1['user']['email'].toString();
//         // mobile = UserData1['user']['mobile'].toString();
//         // workStatus = UserData1['user']['workStatus'].toString();
//         // currentCity = UserData1['user']['currentCity'].toString();
//         // aboutUser = UserData1['user']['aboutUser'].toString();
//         print(' Token : $token');
//       });
//     });

//     super.initState();
//     fetchDataFuture = fetchData();
//   }

//   Future<void> fetchData() async {
//     await Future.delayed(Duration(microseconds: 20));
//     final profileDetailsViewmodel =
//         Provider.of<ProfileDetailsViewmodel>(context, listen: false);

//     await profileDetailsViewmodel.fetchProfileDetailsApi(
//         ipAddress.toString(), email.toString(), token.toString());
//   }

//   final List<String> _proficiencyLevels = [
//     'Beginner',
//     'Intermediate',
//     'Expert'
//   ];

//   void _updateContent(String section, dynamic newContent) {
//     setState(() {
//       switch (section) {
//         case 'About':
//             final editUserAboutInfoViewModel =
//         Provider.of<EditUserAboutInfoViewModel>(context, listen: false);
//         Map<String, String> data = {

//           "aboutUser" : newContent.toString()
//         };

// editUserAboutInfoViewModel.editUserAboutInfoApi(ipAddress, token.toString(), data, context);
//           UserData.aboutText = newContent as String;
//           break;
//         case 'Career Preferences':
//           UserData.careerPreferences =
//               (newContent as List<Map<String, String>>);
//           break;
//         case 'Skills':
//           UserData.skills = (newContent as List<String>);
//           break;
//         case 'Languages Known':
//           UserData.languages = List<Map<String, String>>.from(newContent);
//           break;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileDetailsViewmodel =
//         Provider.of<ProfileDetailsViewmodel>(context, listen: false);

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: FutureBuilder<void>(
//         future: fetchDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error occurred: ${snapshot.error}'));
//           } else {
//             return ChangeNotifierProvider<ProfileDetailsViewmodel>.value(
//               value: profileDetailsViewmodel,
//               child: Consumer<ProfileDetailsViewmodel>(
//                 builder: (context, value, _) {
//                   switch (value.profileDetails.status!) {
//                     case Status.LOADING:
//                       return Center(child: CircularProgressIndicator());
//                     case Status.ERROR:
//                       return Center(child: Text(value.toString()));
//                     case Status.COMPLETED:
//                       var profileDetails =
//                           value.profileDetails.data!.userBasicDetailsList;

//                       print(
//                           '222222222222222222222222222222222222222222222222222222222222222222222222');
//                       print(profileDetails![0].userProfilePhoto.toString());
//                       print(value
//                           .profileDetails.data!.userBasicDetailsList![0].name);

//                       print(
//                           '222222222222222222222222222222222222222222222222222222222222222222222222');
//                       return SafeArea(
//                         child: Column(
//                           children: [
//                             // Fixed Header
//                             Container(
//                               color: Colors.black,
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 16.0, vertical: 12.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   // IconButton(
//                                   //   icon: Icon(Icons.arrow_back,
//                                   //       color: Color(0xFFCCFF00)),
//                                   //   onPressed: () => Navigator.pop(context),
//                                   // ),
//                                   Text(
//                                     'Profile',
//                                     style: GoogleFonts.plusJakartaSans(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   IconButton(
//                                     icon: Icon(Icons.more_vert,
//                                         color: Colors.white),
//                                     onPressed: () {},
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // Scrollable Content
//                             Expanded(
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     // Profile Section with Neon Background
//                                     Container(
//                                       width: double.infinity,
//                                       color: Color(0xFFCCFF00),
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 24, vertical: 48),
//                                             child: Column(
//                                               children: [
//                                                 Container(
//                                                     width: 15.h,
//                                                     height: 15.h,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black
//                                                           .withOpacity(0.2),
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     clipBehavior: Clip.hardEdge,
//                                                     child: Image.network(
//                                                       profileDetails[0]
//                                                           .userProfilePhoto
//                                                           .toString(),
//                                                       fit: BoxFit
//                                                           .cover, // Change from contain to cover
//                                                       // width: double.infinity,
//                                                       // height: double.infinity,
//                                                     )

//                                                     //  Icon(
//                                                     //   Icons
//                                                     //       .add_photo_alternate_outlined,
//                                                     //   color: Colors.black,
//                                                     //   size: 8.h,
//                                                     // ),
//                                                     ),
//                                                 SizedBox(height: 16),
//                                                 Text(
//                                                   profileDetails[0]
//                                                       .name
//                                                       .toString(),
//                                                   style: GoogleFonts
//                                                       .plusJakartaSans(
//                                                     color: Colors.black,
//                                                     fontSize: 22,
//                                                     fontWeight: FontWeight.w700,
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 2),
//                                                 Text(
//                                                   workStatus ?? '',
//                                                   style: GoogleFonts
//                                                       .plusJakartaSans(
//                                                     color: Colors.black
//                                                         .withOpacity(0.7),
//                                                     fontSize: 16,
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 16),
//                                                 ElevatedButton.icon(
//                                                   onPressed: () {},
//                                                   icon: Icon(
//                                                     Icons.download,
//                                                     color: Color(0xFFCCFF00),
//                                                     size: 18,
//                                                   ),
//                                                   label: Text(
//                                                     'Download Resume',
//                                                     style: GoogleFonts
//                                                         .plusJakartaSans(
//                                                       color: Color(0xFFCCFF00),
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                     ),
//                                                   ),
//                                                   style:
//                                                       ElevatedButton.styleFrom(
//                                                     backgroundColor:
//                                                         Colors.black,
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                             horizontal: 20,
//                                                             vertical: 10),
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               8),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           // Profile Picture Container

//                                           _buildSectionWithBackground(
//                                             'About',
//                                             profileDetails[0].aboutUser ?? '',
//                                             showMore: false
//                                           ,
//                                           ),

//                                           Container(
//                                               height: 1.5.h, width: 100.w),
//                                           // Career Preferences Section
//                                           _buildPreferencesSection(
//                                               'Career Preferences', [
//                                             {
//                                               'Preferred Work Location':
//                                                   profileDetails[0]
//                                                           .otherDetails?[0]
//                                                           .preferredWorkLocation ??
//                                                       '',
//                                             },
//                                             {
//                                               'Preferred Salary':
//                                                   profileDetails[0]
//                                                           .otherDetails?[0]
//                                                           .preferredSalary ??
//                                                       ''
//                                             },
//                                             {
//                                               'Resume Headline':
//                                                   profileDetails[0]
//                                                           .otherDetails?[0]
//                                                           .resumeHeadline ??
//                                                       ''
//                                             },
//                                           ]),
//                                           Container(
//                                               height: 1.5.h, width: 100.w),

//                                           // Skills Section
//                                           _buildSkillsSection(
//                                               'Skills',
//                                               profileDetails[0]
//                                                   .keySkillsDetails),

//                                           // Languages Section
//                                           _buildLanguagesSection(
//                                               'Languages Known',
//                                               profileDetails[0]
//                                                   .languageDetails),
//                                           Container(
//                                               height: 1.5.h, width: 100.w),
//                                              _buildEducationSection(),
//                                           Container(
//                                               height: 1.5.h, width: 100.w),
//                                           _buildProjectSection(),
//                                           Container(
//                                               height: 1.5.h, width: 100.w),
//                                           _buildWorkExperienceSection(),
//                                           Container(
//                                               height: 1.5.h, width: 100.w),
//                                           _buildCertificatesSection(),
//                                           Container(
//                                               height: 1.5.h, width: 100.w),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                   }
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildSectionWithBackground(
//     String title,
//     String content, {
//     bool showMore = false,
//   }) {

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 title,
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFFCCFF00),
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () {
//                   _showEditDialog(context, title, content, null, null);
//                 },
//                 child: Icon(
//                   Icons.edit_outlined,
//                   color: Color(0xFFCCFF00).withOpacity(0.7),
//                   size: 16,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),

//           Html(
//             data: content,
//             style: {
//               "p": Style(
//                 color: Colors.white,
//                 fontSize: FontSize(14),
//                 fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
//                 lineHeight: LineHeight(1.5),
//               ),
//             },
//           ),
//           // Text(
//           //   content,
//           //   style: GoogleFonts.plusJakartaSans(
//           //     color: Colors.white,
//           //     height: 1.5,
//           //     fontSize: 14,
//           //   ),
//           // ),
//           if (showMore)
//             Align(
//               alignment: Alignment.centerLeft,
//               child: TextButton(
//                 onPressed: () {},
//                 style: TextButton.styleFrom(
//                   padding: EdgeInsets.zero,
//                   minimumSize: Size.zero,
//                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 ),
//                 child: Text(
//                   'See more',
//                   style: GoogleFonts.plusJakartaSans(
//                     color: Colors.white70,
//                     decoration: TextDecoration.underline,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPreferencesSection(
//       String title, List<Map<String, String>> preferences) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 title,
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFFCCFF00),
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () {
//                   _showEditDialog(context, title, null, null, null);
//                 },
//                 child: Icon(
//                   Icons.edit_outlined,
//                   color: Color(0xFFCCFF00).withOpacity(0.7),
//                   size: 16,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           ...preferences.map((pref) =>
//               _buildPreferenceItem(pref.keys.first, pref.values.first)),
//         ],
//       ),
//     );
//   }

//   Widget _buildSkillsSection(String title, List<KeySkillsDetails>? skills) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 title,
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFFCCFF00),
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () {
//                   // _showEditDialog(context, title, null, null, skills.to);
//                 },
//                 child: Icon(
//                   Icons.edit_outlined,
//                   color: Color(0xFFCCFF00).withOpacity(0.7),
//                   size: 16,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: skills!
//                 .map((skill) => _buildChip(skill.skillName.toString()))
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLanguagesSection(
//       String title, List<LanguageDetails>? languages) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 title,
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFFCCFF00),
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () {
//                   _showEditDialog(context, title, null, null, null);
//                 },
//                 child: Icon(
//                   Icons.edit_outlined,
//                   color: Color(0xFFCCFF00).withOpacity(0.7),
//                   size: 16,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           ...languages!.map((lang) => _buildLanguageItem(
//               lang.language.toString(), lang.proficiency.toString())),
//         ],
//       ),
//     );
//   }

//   Widget _buildPreferenceItem(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: GoogleFonts.plusJakartaSans(
//               color: Colors.white70,
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             value,
//             style: GoogleFonts.plusJakartaSans(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLanguageItem(String language, String level) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Text(
//             language,
//             style: GoogleFonts.plusJakartaSans(
//               color: Colors.white,
//               fontSize: 14,
//             ),
//           ),
//           SizedBox(width: 16),
//           Text(
//             level,
//             style: GoogleFonts.plusJakartaSans(
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildChip(String label) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         label,
//         style: GoogleFonts.plusJakartaSans(
//           color: Colors.white,
//           fontSize: 12,
//         ),
//       ),
//     );
//   }

//   void _showEditDialog(BuildContext context, String title, String? content,
//       List<Widget>? items, List<String>? chips) {
//     final TextEditingController textController =
//         TextEditingController(text: content);
//     final List<TextEditingController> itemControllers = [];

//     // Initialize controllers for items if they exist
//     if (title == 'Career Preferences') {
//       for (var pref in UserData.careerPreferences) {
//         itemControllers.add(TextEditingController(text: pref.values.first));
//       }
//     } else if (title == 'Languages Known') {
//       for (var lang in UserData.languages) {
//         String initialValue = lang.values.first;
//         if (!_proficiencyLevels.contains(initialValue)) {
//           initialValue = _proficiencyLevels[0];
//         }
//         itemControllers.add(TextEditingController(text: initialValue));
//       }
//     }

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Color(0xFF1C1C1E),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         child: Text(
//                           'Edit $title',
//                           style: GoogleFonts.plusJakartaSans(
//                             color: Colors.white,
//                             fontSize: 13.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           maxLines: 1,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.close, color: Colors.white),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   if (content != null)
//                     TextField(
//                       controller: textController,
//                       style: GoogleFonts.plusJakartaSans(color: Colors.white),
//                       maxLines: null,
//                       decoration: InputDecoration(
//                         hintText: 'Enter your $title',
//                         hintStyle: GoogleFonts.plusJakartaSans(
//                           color: Colors.white.withOpacity(0.5),
//                         ),
//                         filled: true,
//                         fillColor: Colors.black,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   if (title == 'Career Preferences' ||
//                       title == 'Languages Known')
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: itemControllers.length,
//                       itemBuilder: (context, index) {
//                         final label = title == 'Career Preferences'
//                             ? UserData.careerPreferences[index].keys.first
//                             : UserData.languages[index].keys.first;
//                         return Padding(
//                           padding: EdgeInsets.only(bottom: 8),
//                           child: title == 'Languages Known'
//                               ? Row(
//                                   children: [
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         label,
//                                         style: GoogleFonts.plusJakartaSans(
//                                           color: Colors.white70,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(width: 16),
//                                     Expanded(
//                                       flex: 3,
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 12),
//                                         decoration: BoxDecoration(
//                                           color: Colors.black,
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                           border: Border.all(
//                                             color: Colors.white24,
//                                             width: 1,
//                                           ),
//                                         ),
//                                         child: DropdownButtonHideUnderline(
//                                           child: DropdownButton<String>(
//                                             value: itemControllers[index].text,
//                                             dropdownColor: Color(0xFF1C1C1E),
//                                             style: GoogleFonts.plusJakartaSans(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                             ),
//                                             icon: Icon(
//                                               Icons.arrow_drop_down,
//                                               color: Colors.white,
//                                             ),
//                                             isExpanded: true,
//                                             items: _proficiencyLevels
//                                                 .map((String level) {
//                                               return DropdownMenuItem<String>(
//                                                 value: level,
//                                                 child: Text(
//                                                   level,
//                                                   style: GoogleFonts
//                                                       .plusJakartaSans(
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                             onChanged: (String? newValue) {
//                                               if (newValue != null) {
//                                                 setState(() {
//                                                   itemControllers[index].text =
//                                                       newValue;
//                                                   // Update the languages list immediately
//                                                   final newLangs = List<
//                                                           Map<String,
//                                                               String>>.from(
//                                                       UserData.languages);
//                                                   newLangs[index] = {
//                                                     UserData.languages[index]
//                                                         .keys.first: newValue
//                                                   };
//                                                   _updateContent(
//                                                       'Languages Known',
//                                                       newLangs);
//                                                 });
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               : TextField(
//                                   controller: itemControllers[index],
//                                   style: GoogleFonts.plusJakartaSans(
//                                       color: Colors.white),
//                                   decoration: InputDecoration(
//                                     labelText: label,
//                                     labelStyle: GoogleFonts.plusJakartaSans(
//                                       color: Colors.white70,
//                                     ),
//                                     filled: true,
//                                     fillColor: Colors.black,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                   ),
//                                 ),
//                         );
//                       },
//                     ),
//                   if (title == 'Skills')
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: UserData.skills.map((skill) {
//                             return Chip(
//                               label: Text(skill),
//                               deleteIcon: Icon(Icons.close, size: 16),
//                               onDeleted: () {
//                                 setState(() {
//                                   UserData.skills.remove(skill);
//                                 });
//                                 Navigator.pop(context);
//                                 _showEditDialog(context, title, content, items,
//                                     UserData.skills);
//                               },
//                             );
//                           }).toList(),
//                         ),
//                         SizedBox(height: 8),
//                         TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Add new skill',
//                             suffixIcon: IconButton(
//                               icon: Icon(Icons.add, color: Colors.white),
//                               onPressed: () {
//                                 final newSkill = textController.text.trim();
//                                 if (newSkill.isNotEmpty) {
//                                   setState(() {
//                                     UserData.skills.add(newSkill);
//                                   });
//                                   textController.clear();
//                                   Navigator.pop(context);
//                                   _showEditDialog(context, title, content,
//                                       items, UserData.skills);
//                                 }
//                               },
//                             ),
//                           ),
//                           controller: textController,
//                           style:
//                               GoogleFonts.plusJakartaSans(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: Text(
//                           'Cancel',
//                           style: GoogleFonts.plusJakartaSans(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Save changes based on section
//                           switch (title) {
//                             case 'About':
//                               _updateContent(title, textController.text);
//                               break;
//                             case 'Career Preferences':
//                               final newPrefs =
//                                   List<Map<String, String>>.generate(
//                                 UserData.careerPreferences.length,
//                                 (index) => {
//                                   UserData.careerPreferences[index].keys.first:
//                                       itemControllers[index].text
//                                 },
//                               );
//                               _updateContent(title, newPrefs);
//                               break;
//                             case 'Languages Known':
//                               final newLangs =
//                                   List<Map<String, String>>.generate(
//                                 UserData.languages.length,
//                                 (index) => {
//                                   UserData.languages[index].keys.first:
//                                       itemControllers[index].text
//                                 },
//                               );
//                               _updateContent(title, newLangs);
//                               break;
//                           }
//                           Navigator.pop(context);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFFCCFF00),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           'Save',
//                           style: GoogleFonts.plusJakartaSans(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showNameEditDialog(BuildContext context) {
//     final TextEditingController nameController =
//         TextEditingController(text: UserData.userName);

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.black,
//         title: Text(
//           'Edit Name',
//           style: GoogleFonts.plusJakartaSans(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         content: TextField(
//           controller: nameController,
//           style: GoogleFonts.plusJakartaSans(
//             color: Colors.white,
//           ),
//           decoration: InputDecoration(
//             hintText: 'Enter your name',
//             hintStyle: GoogleFonts.plusJakartaSans(
//               color: Colors.white54,
//             ),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.white24),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Color(0xFFCCFF00)),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               'Cancel',
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 UserData.userName = nameController.text;
//               });
//               Navigator.pop(context);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFFCCFF00),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               'Save',
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEducationSection() {
//     final profileDetailsViewmodel =
//         Provider.of<ProfileDetailsViewmodel>(context, listen: false);
//     var profileDetails =
//         profileDetailsViewmodel.profileDetails.data!.userBasicDetailsList![0];

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     'Education',
//                     style: GoogleFonts.plusJakartaSans(
//                       color: Color(0xFFCCFF00),
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Icon(
//                     Icons.edit_outlined,
//                     color: Color(0xFFCCFF00).withOpacity(0.7),
//                     size: 16,
//                   ),
//                 ],
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // Add education functionality
//                 },
//                 child: Text(
//                   'Add',
//                   style: GoogleFonts.plusJakartaSans(
//                     color: Color(0xFFCCFF00),
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           ...profileDetails.educationDetail!
//               .map((education) => _buildEducationItem(education))
//               .toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildEducationItem(EducationDetail education) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               '${education.courseDetails!.courseName} in ${education.specificationDetails!.specificationName.toString()}',
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(width: 8),
//             Icon(
//               Icons.edit_outlined,
//               color: Colors.white.withOpacity(0.7),
//               size: 16,
//             ),
//           ],
//         ),
//         SizedBox(height: 4),
//         Text(
//           education.universityDetails!.universityName.toString(),
//           style: GoogleFonts.plusJakartaSans(
//             color: Colors.white.withOpacity(0.7),
//             fontSize: 14,
//           ),
//         ),
//         SizedBox(height: 4),
//         Row(
//           children: [
//             Icon(
//               Icons.calendar_today_outlined,
//               color: Colors.white.withOpacity(0.5),
//               size: 14,
//             ),
//             SizedBox(width: 4),
//             Text(
//               '${education.startingYear} - ${education.passingYear}',
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white.withOpacity(0.5),
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }

// // Add this inside the build method where you want to display the project section
//   Widget _buildProjectSection() {
//     final profileDetailsViewmodel =
//         Provider.of<ProfileDetailsViewmodel>(context, listen: false);
//     var profileDetails =
//         profileDetailsViewmodel.profileDetails.data!.userBasicDetailsList![0];

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Project',
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFFCCFF00),
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // Add project functionality
//                 },
//                 child: Text(
//                   'Add',
//                   style: GoogleFonts.plusJakartaSans(
//                     color: Color(0xFFCCFF00),
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           ...profileDetails.projectDetails!
//               .map((project) => _buildProjectItem(project))
//               .toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildProjectItem(ProjectDetails project) {
//     String duration = project.endDate != null
//         ? 'Durations - ${project.startDate} - ${project.endDate}'
//         : 'Durations - ${project.startDate} - Present';

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               project.name.toString(),
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(width: 8),
//             Icon(
//               Icons.edit_outlined,
//               color: Colors.white.withOpacity(0.7),
//               size: 16,
//             ),
//           ],
//         ),
//         SizedBox(height: 4),
//         Text(
//           project.description.toString(),
//           style: GoogleFonts.plusJakartaSans(
//             color: Colors.white.withOpacity(0.7),
//             fontSize: 14,
//           ),
//           maxLines: 3,
//           overflow: TextOverflow.ellipsis,
//         ),
//         SizedBox(height: 4),
//         Row(
//           children: [
//             Text(
//               'Status - ${project.status}',
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white.withOpacity(0.5),
//                 fontSize: 12,
//               ),
//             ),
//             SizedBox(width: 8),
//             Text(
//               duration,
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white.withOpacity(0.5),
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }

// // Add this inside the build method where you want to display the work experience section
//   Widget _buildWorkExperienceSection() {
//     final profileDetailsViewmodel =
//         Provider.of<ProfileDetailsViewmodel>(context, listen: false);
//     var profileDetails =
//         profileDetailsViewmodel.profileDetails.data!.userBasicDetailsList![0];

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Work Experience',
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFFCCFF00),
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // Add work experience functionality
//                 },
//                 child: Text(
//                   'Add',
//                   style: GoogleFonts.plusJakartaSans(
//                     color: Color(0xFFCCFF00),
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           ...profileDetails.employmentDetails!
//               .map((employment) => _buildWorkExperienceItem(employment))
//               .toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildWorkExperienceItem(EmploymentDetails employment) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               employment.currentJobTitle.toString(),
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(width: 8),
//             Icon(
//               Icons.edit_outlined,
//               color: Colors.white.withOpacity(0.7),
//               size: 16,
//             ),
//           ],
//         ),
//         SizedBox(height: 4),
//         Text(
//           employment.companyName.toString(),
//           style: GoogleFonts.plusJakartaSans(
//             color: Colors.white.withOpacity(0.7),
//             fontSize: 14,
//           ),
//         ),
//         SizedBox(height: 4),
//         Row(
//           children: [
//             Icon(
//               Icons.calendar_today_outlined,
//               color: Colors.white.withOpacity(0.5),
//               size: 14,
//             ),
//             SizedBox(width: 4),
//             Text(
//               '${employment.fromDuration} - ${employment.toDuration!.isEmpty ? "Present" : employment.toDuration} - ${employment.totalWorkExperienced}',
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white.withOpacity(0.5),
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 4),
//         Row(
//           children: [
//             Icon(
//               Icons.location_on_outlined,
//               color: Colors.white.withOpacity(0.5),
//               size: 14,
//             ),
//             SizedBox(width: 4),
//             Text(
//               employment.currentCity.toString(),
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white.withOpacity(0.5),
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }

// // Add this inside the build method where you want to display the courses & certificate section
//   Widget _buildCertificatesSection() {
//     final profileDetailsViewmodel =
//         Provider.of<ProfileDetailsViewmodel>(context, listen: false);
//     var profileDetails =
//         profileDetailsViewmodel.profileDetails.data!.userBasicDetailsList![0];

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Courses & Certificate',
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFFCCFF00),
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // Add certificate functionality
//                 },
//                 child: Text(
//                   'Add',
//                   style: GoogleFonts.plusJakartaSans(
//                     color: Color(0xFFCCFF00),
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           ...profileDetails.coursesCertificateDetails!
//               .map((certificate) => _buildCertificateItem(certificate))
//               .toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildCertificateItem(CoursesCertificateDetails certificate) {
//     String fileName = certificate.certificateImage!.split('/').last;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               certificate.certificateName.toString(),
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(width: 8),
//             Icon(
//               Icons.edit_outlined,
//               color: Colors.white.withOpacity(0.7),
//               size: 16,
//             ),
//           ],
//         ),
//         SizedBox(height: 4),
//         Text(
//           certificate.issueBy.toString(),
//           style: GoogleFonts.plusJakartaSans(
//             color: Colors.white.withOpacity(0.7),
//             fontSize: 14,
//           ),
//         ),
//         if (certificate.isExpiryTime! && certificate.expiryDate != null)
//           Row(
//             children: [
//               Icon(
//                 Icons.calendar_today_outlined,
//                 color: Colors.white.withOpacity(0.5),
//                 size: 14,
//               ),
//               SizedBox(width: 4),
//               Text(
//                 certificate.expiryDate!,
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Colors.white.withOpacity(0.5),
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         SizedBox(height: 8),
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.withOpacity(0.3)),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         fileName,
//                         style: GoogleFonts.plusJakartaSans(
//                           color: Colors.white.withOpacity(0.7),
//                           fontSize: 12,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Icon(
//                       Icons.open_in_new,
//                       color: Colors.white.withOpacity(0.7),
//                       size: 16,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }
// }

// class UserData {
//   static String userName = 'Vishnu Prajapati';
//   static String aboutText =
//       'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled...';

//   static List<Map<String, String>> careerPreferences = [
//     {'Preferred Work Location': 'Vadodara'},
//     {'Preferred Salary': '2,80,000 / Annum'},
//     {'Resume Headline': 'Full Stack Developer'},
//   ];

//   static List<String> skills = ['Javascript', 'HTML5', 'CSS'];

//   static List<Map<String, String>> languages = [
//     {'English': 'Expert'},
//     {'Hindi': 'Expert'},
//   ];
// }

// class ProfileScreen extends StatefulWidget {
//   ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   late Future<void> fetchDataFuture;
//   String ipAddress = '103.241.225.195';
//   String? token;
//   UserPreferences userPreference = UserPreferences();
//   dynamic UserData1;
//   String? profileLogo;
//   String? name;
//   String? email;
//   String? mobile;
//   String? workStatus;
//   String? currentCity;
//   String? aboutUser;
//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker();
//   String? _uploadedFileUrl;

//   @override
//   void initState() {
//     userPreference.getUserData().then((value) {
//       setState(() {
//         UserData1 = value!;
//         token = UserData1['refresh'].toString();
//         // profileLogo = UserData1['user']['userProfilePhoto'].toString();
//         // name = UserData1['user']['name'].toString();
//         email = UserData1['user']['email'].toString();
//         // mobile = UserData1['user']['mobile'].toString();
//         // workStatus = UserData1['user']['workStatus'].toString();
//         // currentCity = UserData1['user']['currentCity'].toString();
//         // aboutUser = UserData1['user']['aboutUser'].toString();
//         print(' Token : $token');
//       });
//     });

//     super.initState();
//     fetchDataFuture = fetchData();
//   }

//   Future<void> fetchData() async {
//     await Future.delayed(Duration(microseconds: 20));
//     final profileDetailsViewmodel =
//         Provider.of<ProfileDetailsViewmodel>(context, listen: false);

//     await profileDetailsViewmodel.fetchProfileDetailsApi(
//         ipAddress.toString(), email.toString(), token.toString());

//     final getSkillListViewmodel =
//         Provider.of<GetSkillListViewmodel>(context, listen: false);

//     await getSkillListViewmodel.fetchGetSkillListApi(
//         ipAddress.toString(), token.toString());
//   }

//   final List<String> _proficiencyLevels = [
//     'Beginner',
//     'Intermediate',
//     'Expert'
//   ];

//   Future<void> _pickImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//       // Upload image immediately
//       // await _uploadPdfToServer(_imageFile!);
//     }
//   }

//   void _updateContent(String section, dynamic newContent) {
//     setState(() {
//       switch (section) {
//         case 'About':
//           final editUserAboutInfoViewModel =
//               Provider.of<EditUserAboutInfoViewModel>(context, listen: false);
//           Map<String, String> data = {"aboutUser": newContent.toString()};

//           editUserAboutInfoViewModel.editUserAboutInfoApi(
//               ipAddress, token.toString(), data, context);
//           // UserData.aboutText = newContent as String;
//           break;
//         case 'Basic Info':
//           final editBasicInfoViewModel =
//               Provider.of<EditUserProfileDetailsViewModel>(context,
//                   listen: false);

// //                             Map<String, String> data = {'name':,
// // 'workStatus':
// // };

//           editBasicInfoViewModel.editUserProfileDetailsApi(
//               ipAddress, token.toString(), newContent, context);
//           break;

//         case 'Career Preferences':
//           final profileDetailsViewmodel =
//               Provider.of<ProfileDetailsViewmodel>(context, listen: false);

//           final editOtherDetailsViewModel =
//               Provider.of<EditOtherDetailsViewModel>(context, listen: false);

//           print(
//               'section  section  section  section  section  section  section  section  section  section  section  ');
//           print(section);
//           print(newContent);
//           print(newContent[0]);

//           print(newContent[0]['PreferredWorkLocation']);
//           print(
//               'section  section  section  section  section  section  section  section  section  section  section  ');

//           Map<String, String> data = {
//             'otherDetailsId': profileDetailsViewmodel.profileDetails.data!
//                 .userBasicDetailsList![0].otherDetails![0].id
//                 .toString(),
//             'resumeHeadline': newContent[2]['ResumeHeadline'],
//             'preferredWorkLocation': newContent[0]['PreferredWorkLocation'],
//             'preferredSalary': newContent[1]['PreferredSalary'],
//             'gender': profileDetailsViewmodel.profileDetails.data!
//                 .userBasicDetailsList![0].otherDetails![0].gender
//                 .toString()
//           };

//           editOtherDetailsViewModel.editOtherDetailsApi(
//               ipAddress, token.toString(), data, context);

//           // UserData.careerPreferences =
//           //     (newContent as List<Map<String, String>>);
//           break;
//         case 'Skills':
//           // UserData.skills = (newContent as List<String>);
//           break;
//         case 'Languages Known':
//           // UserData.languages = List<Map<String, String>>.from(newContent);
//           break;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileDetailsViewmodel =
//         Provider.of<ProfileDetailsViewmodel>(context, listen: false);
//     final getSkillListViewmodel =
//         Provider.of<GetSkillListViewmodel>(context, listen: false);

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: FutureBuilder<void>(
//         future: fetchDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error occurred: ${snapshot.error}'));
//           } else {
//             return ChangeNotifierProvider<ProfileDetailsViewmodel>.value(
//               value: profileDetailsViewmodel,
//               child: Consumer<ProfileDetailsViewmodel>(
//                 builder: (context, value, _) {
//                   switch (value.profileDetails.status!) {
//                     case Status.LOADING:
//                       return Center(child: CircularProgressIndicator());
//                     case Status.ERROR:
//                       return Center(child: Text(value.toString()));
//                     case Status.COMPLETED:
//                       var profileDetails =
//                           value.profileDetails.data!.userBasicDetailsList;

//                       print(
//                           '222222222222222222222222222222222222222222222222222222222222222222222222');
//                       print(profileDetails![0].userProfilePhoto.toString());
//                       print(value
//                           .profileDetails.data!.userBasicDetailsList![0].name);

//                       print(
//                           '222222222222222222222222222222222222222222222222222222222222222222222222');
//                       return SafeArea(
//                         child: Column(
//                           children: [
//                             // Fixed Header
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 24, vertical: 48),
//                               color: Color(0xFFCCFF00),
//                               child: Column(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: _pickImage,
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           width: 15.h,
//                                           height: 15.h,
//                                           decoration: BoxDecoration(
//                                             color:
//                                                 Colors.black.withOpacity(0.2),
//                                             shape: BoxShape.circle,
//                                           ),
//                                           clipBehavior: Clip.hardEdge,
//                                           child: _imageFile != null
//                                               ? Image.file(
//                                                   _imageFile!,
//                                                   fit: BoxFit.cover,
//                                                 )
//                                               : Image.network(
//                                                   profileDetails![0]
//                                                       .userProfilePhoto
//                                                       .toString(),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                         ),
//                                         Positioned(
//                                           right: 0,
//                                           bottom: 0,
//                                           child: Container(
//                                             padding: EdgeInsets.all(4),
//                                             decoration: BoxDecoration(
//                                               color: Colors.black,
//                                               shape: BoxShape.circle,
//                                             ),
//                                             child: Icon(
//                                               Icons.edit,
//                                               color: Color(0xFFCCFF00),
//                                               size: 16,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 16),
//                                   GestureDetector(
//                                     onTap: () {},
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           profileDetails[0].name.toString(),
//                                           style: GoogleFonts.plusJakartaSans(
//                                             color: Colors.black,
//                                             fontSize: 22,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                         SizedBox(width: 4),
//                                         Icon(
//                                           Icons.edit_outlined,
//                                           color: Colors.black.withOpacity(0.7),
//                                           size: 16,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 2),
//                                   GestureDetector(
//                                     onTap: () {},
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           profileDetails[0].workStatus ?? '',
//                                           style: GoogleFonts.plusJakartaSans(
//                                             color:
//                                                 Colors.black.withOpacity(0.7),
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                         SizedBox(width: 4),
//                                         Icon(
//                                           Icons.edit_outlined,
//                                           color: Colors.black.withOpacity(0.5),
//                                           size: 14,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 16),
//                                   ElevatedButton.icon(
//                                     onPressed: () {},
//                                     icon: Icon(
//                                       Icons.download,
//                                       color: Color(0xFFCCFF00),
//                                       size: 18,
//                                     ),
//                                     label: Text(
//                                       'Download Resume',
//                                       style: GoogleFonts.plusJakartaSans(
//                                         color: Color(0xFFCCFF00),
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.black,
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 20, vertical: 10),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             Expanded(
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     _buildSectionWithBackground(
//                                       'About',
//                                       profileDetails![0].aboutUser ?? '',
//                                       showMore: false,
//                                       profileDetails: profileDetails,
//                                     ),
//                                     Container(height: 1.5.h, width: 100.w),
//                                     _buildProjectSection(),
//                                     Container(height: 1.5.h, width: 100.w),
//                                     _buildWorkExperienceSection(),
//                                     Container(height: 1.5.h, width: 100.w),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                   }
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   // Add this inside the build method where you want to display the project section
//   Widget _buildProjectSection() {
//     final profileDetailsViewmodel =
//         Provider.of<ProfileDetailsViewmodel>(context, listen: false);
//     var profileDetails =
//         profileDetailsViewmodel.profileDetails.data!.userBasicDetailsList![0];

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Project',
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFFCCFF00),
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => AddProjectScreen()),
//                   );
//                 },
//                 child: Text(
//                   'Add',
//                   style: GoogleFonts.plusJakartaSans(
//                     color: Color(0xFFCCFF00),
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           ...profileDetails.projectDetails!
//               .map((project) => _buildProjectItem(project))
//               .toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildProjectItem(ProjectDetails project) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               project.name.toString(),
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(width: 8),
//             Icon(
//               Icons.edit_outlined,
//               color: Colors.white.withOpacity(0.7),
//               size: 16,
//             ),
//           ],
//         ),
//         SizedBox(height: 4),
//         Text(
//           project.description.toString(),
//           style: GoogleFonts.plusJakartaSans(
//             color: Colors.white.withOpacity(0.7),
//             fontSize: 14,
//           ),
//           maxLines: 3,
//           overflow: TextOverflow.ellipsis,
//         ),
//         SizedBox(height: 4),
//         SizedBox(height: 16),
//       ],
//     );
//   }

// // Add this inside the build method where you want to display the work experience section
//   Widget _buildWorkExperienceSection() {
//     final profileDetailsViewmodel =
//         Provider.of<ProfileDetailsViewmodel>(context, listen: false);
//     var profileDetails =
//         profileDetailsViewmodel.profileDetails.data!.userBasicDetailsList![0];

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Work Experience',
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFFCCFF00),
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddWorkExperienceScreen(),
//       ),
//     );
//                 },
//                 child: Text(
//                   'Add',
//                   style: GoogleFonts.plusJakartaSans(
//                     color: Color(0xFFCCFF00),
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           ...profileDetails.employmentDetails!
//               .map((employment) => _buildWorkExperienceItem(employment))
//               .toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildWorkExperienceItem(EmploymentDetails employment) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               employment.currentJobTitle.toString(),
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(width: 8),
//             Icon(
//               Icons.edit_outlined,
//               color: Colors.white.withOpacity(0.7),
//               size: 16,
//             ),
//           ],
//         ),
//         SizedBox(height: 4),
//         Text(
//           employment.companyName.toString(),
//           style: GoogleFonts.plusJakartaSans(
//             color: Colors.white.withOpacity(0.7),
//             fontSize: 14,
//           ),
//         ),
//         SizedBox(height: 4),
//         Row(
//           children: [
//             Icon(
//               Icons.calendar_today_outlined,
//               color: Colors.white.withOpacity(0.5),
//               size: 14,
//             ),
//             SizedBox(width: 4),
//             Text(
//               '${employment.fromDuration} - ${employment.toDuration!.isEmpty ? "Present" : employment.toDuration} - ${employment.totalWorkExperienced}',
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white.withOpacity(0.5),
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 4),
//         Row(
//           children: [
//             Icon(
//               Icons.location_on_outlined,
//               color: Colors.white.withOpacity(0.5),
//               size: 14,
//             ),
//             SizedBox(width: 4),
//             Text(
//               employment.currentCity.toString(),
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white.withOpacity(0.5),
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildSectionWithBackground(String title, String content,
//       {bool showMore = false,
//       required List<UserBasicDetailsList> profileDetails}) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 title,
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFFCCFF00),
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () {
//                   _showEditDialog(
//                       context, title, content, null, null, profileDetails);
//                 },
//                 child: Icon(
//                   Icons.edit_outlined,
//                   color: Color(0xFFCCFF00).withOpacity(0.7),
//                   size: 16,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),

//           Html(
//             data: content,
//             style: {
//               "p": Style(
//                 color: Colors.white,
//                 fontSize: FontSize(14),
//                 fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
//                 lineHeight: LineHeight(1.5),
//               ),
//             },
//           ),
//           // Text(
//           //   content,
//           //   style: GoogleFonts.plusJakartaSans(
//           //     color: Colors.white,
//           //     height: 1.5,
//           //     fontSize: 14,
//           //   ),
//           // ),
//           if (showMore)
//             Align(
//               alignment: Alignment.centerLeft,
//               child: TextButton(
//                 onPressed: () {},
//                 style: TextButton.styleFrom(
//                   padding: EdgeInsets.zero,
//                   minimumSize: Size.zero,
//                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 ),
//                 child: Text(
//                   'See more',
//                   style: GoogleFonts.plusJakartaSans(
//                     color: Colors.white70,
//                     decoration: TextDecoration.underline,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   void _showEditDialog(
//       BuildContext context,
//       String title,
//       String? content,
//       List<Widget>? items,
//       List<String>? chips,
//       List<UserBasicDetailsList> profileDetails) {
//     final TextEditingController textController =
//         TextEditingController(text: content);
//     final List<TextEditingController> itemControllers = [];
//     print(
//         'titletitletitletitletitletitletitletitletitletitletitletitletitletitle');
//     print(title);
//     print(
//         'titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle');
//     // For Skills, keep track of selected skills and available skills
//     List<String> selectedSkills = [];
//     if (title == 'Skills' && profileDetails[0].keySkillsDetails != null) {
//       selectedSkills = profileDetails[0]
//           .keySkillsDetails!
//           .map((s) => s.skillName.toString())
//           .toList();
//     }

//     // Initialize controllers based on API data, not static UserData
//     if (title == 'Career Preferences') {
//       // Use API data for career preferences
//       final preferences = [
//         {
//           'PreferredWorkLocation':
//               profileDetails[0].otherDetails?[0].preferredWorkLocation ?? ''
//         },
//         {
//           'PreferredSalary':
//               profileDetails[0].otherDetails?[0].preferredSalary ?? ''
//         },
//         {
//           'ResumeHeadline':
//               profileDetails[0].otherDetails?[0].resumeHeadline ?? ''
//         },
//       ];

//       for (var pref in preferences) {
//         itemControllers.add(TextEditingController(text: pref.values.first));
//       }
//     } else if (title == 'Languages Known') {
//       // Use API data for languages
//       for (var lang in profileDetails[0].languageDetails ?? []) {
//         String initialValue = lang.proficiency ?? '';
//         if (!_proficiencyLevels.contains(initialValue)) {
//           initialValue = _proficiencyLevels[0];
//         }
//         itemControllers.add(TextEditingController(text: initialValue));
//       }
//     }

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // For Skills dialog, we'll get the full skill list from the viewmodel
//         if (title == 'Skills') {
//           final getSkillListViewmodel =
//               Provider.of<GetSkillListViewmodel>(context, listen: false);
//           return StatefulBuilder(
//             builder: (context, setStateLocal) {
//               return Dialog(
//                 backgroundColor: Color(0xFF1C1C1E),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               child: Text(
//                                 'Edit $title',
//                                 style: GoogleFonts.plusJakartaSans(
//                                   color: Colors.white,
//                                   fontSize: 13.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 maxLines: 1,
//                               ),
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.close, color: Colors.white),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                         // Selected Skills Section
//                         Text(
//                           'Your Skills',
//                           style: GoogleFonts.plusJakartaSans(
//                             color: Colors.white70,
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: selectedSkills.map((skillName) {
//                             return Chip(
//                               label: Text(
//                                 skillName,
//                                 style: GoogleFonts.plusJakartaSans(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               backgroundColor: Colors.black,
//                               deleteIcon: Icon(Icons.close,
//                                   size: 16, color: Colors.white70),
//                               onDeleted: () {
//                                 // Remove skill from selected skills
//                                 setStateLocal(() {
//                                   selectedSkills.remove(skillName);
//                                 });
//                               },
//                             );
//                           }).toList(),
//                         ),
//                         SizedBox(height: 16),
//                         // Add new skill section
//                         Text(
//                           'Add Skills',
//                           style: GoogleFonts.plusJakartaSans(
//                             color: Colors.white70,
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Container(
//                           height: 200,
//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.white24, width: 1),
//                           ),
//                           child: getSkillListViewmodel.getSkillList.data == null
//                               ? Center(child: CircularProgressIndicator())
//                               : ListView.builder(
//                                   shrinkWrap: true,
//                                   itemCount: getSkillListViewmodel
//                                       .getSkillList.data!.keySkillsList!.length,
//                                   itemBuilder: (context, index) {
//                                     final skill = getSkillListViewmodel
//                                         .getSkillList
//                                         .data!
//                                         .keySkillsList![index];
//                                     final skillName =
//                                         skill.skillName.toString();
//                                     final isSelected =
//                                         selectedSkills.contains(skillName);

//                                     return ListTile(
//                                       title: Text(
//                                         skillName,
//                                         style: GoogleFonts.plusJakartaSans(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       trailing: isSelected
//                                           ? Icon(Icons.check_circle,
//                                               color: Color(0xFFCCFF00))
//                                           : Icon(Icons.add_circle_outline,
//                                               color: Colors.white70),
//                                       onTap: () {
//                                         setStateLocal(() {
//                                           // Toggle selection
//                                           if (isSelected) {
//                                             selectedSkills.remove(skillName);
//                                           } else {
//                                             selectedSkills.add(skillName);
//                                           }
//                                         });
//                                       },
//                                     );
//                                   },
//                                 ),
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: Text(
//                                 'Cancel',
//                                 style: GoogleFonts.plusJakartaSans(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             ElevatedButton(
//                               onPressed: () {
//                                 // Call API to update skills with selectedSkills
//                                 // final updateSkillsViewModel =
//                                 //     Provider.of<UpdateSkillsViewModel>(context,
//                                 //         listen: false);
//                                 List<Map<String, dynamic>> formattedSkills = [];

//                                 for (String skillName in selectedSkills) {
//                                   // Find the skill in keySkillsList by name to get its ID
//                                   var matchingSkill = getSkillListViewmodel
//                                       .getSkillList.data!.keySkillsList!
//                                       .firstWhere(
//                                     (skill) =>
//                                         skill.skillName.toString() == skillName,
//                                     // orElse: () => null
//                                   );

//                                   if (matchingSkill != null) {
//                                     // Create an object with keySkillsId
//                                     formattedSkills.add(
//                                         {'"keySkillsId"': matchingSkill.id});
//                                   }
//                                 }

//                                 // Create skills data object based on selectedSkills
//                                 Map<String, String> skillsData = {
//                                   'keySkillsArr': formattedSkills.toString()
//                                 };
//                                 print(selectedSkills);

//                                 print(
//                                     'skillsDataskillsDataskillsDataskillsDataskillsDataskillsDataskillsData');
//                                 print(skillsData);

//                                 print(
//                                     'skillsDataskillsDataskillsDataskillsDataskillsDataskillsDataskillsData');
// // ???
//                                 final updateKeySkillViewModel =
//                                     Provider.of<UpdateKeySkillViewModel>(
//                                         context,
//                                         listen: false);

//                                 // // Call update skill API
//                                 updateKeySkillViewModel.updateKeySkillApi(
//                                     ipAddress,
//                                     token.toString(),
//                                     skillsData,
//                                     context);

//                                 // Navigator.pop(context);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xFFCCFF00),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Save',
//                                 style: GoogleFonts.plusJakartaSans(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         } else {
//           // Original dialog implementation for other edit types

//           return Dialog(
//             backgroundColor: Color(0xFF1C1C1E),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           child: Text(
//                             'Edit $title',
//                             style: GoogleFonts.plusJakartaSans(
//                               color: Colors.white,
//                               fontSize: 13.sp,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             maxLines: 1,
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.close, color: Colors.white),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     if (content != null)
//                       TextField(
//                         controller: textController,
//                         style: GoogleFonts.plusJakartaSans(color: Colors.white),
//                         maxLines: null,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your $title',
//                           hintStyle: GoogleFonts.plusJakartaSans(
//                             color: Colors.white.withOpacity(0.5),
//                           ),
//                           filled: true,
//                           fillColor: Colors.black,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                       ),
//                     if (title == 'Career Preferences' ||
//                         title == 'Languages Known')
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: itemControllers.length,
//                         itemBuilder: (context, index) {
//                           String label;
//                           if (title == 'Career Preferences') {
//                             final preferences = [
//                               {
//                                 'PreferredWorkLocation': profileDetails[0]
//                                         .otherDetails?[0]
//                                         .preferredWorkLocation ??
//                                     ''
//                               },
//                               {
//                                 'PreferredSalary': profileDetails[0]
//                                         .otherDetails?[0]
//                                         .preferredSalary ??
//                                     ''
//                               },
//                               {
//                                 'ResumeHeadline': profileDetails[0]
//                                         .otherDetails?[0]
//                                         .resumeHeadline ??
//                                     ''
//                               },
//                             ];
//                             label = preferences[index].keys.first;
//                           } else {
//                             label = profileDetails[0]
//                                     .languageDetails?[index]
//                                     .language ??
//                                 '';
//                           }

//                           return Padding(
//                             padding: EdgeInsets.only(bottom: 8),
//                             child: title == 'Languages Known'
//                                 ? Row(
//                                     children: [
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           label,
//                                           style: GoogleFonts.plusJakartaSans(
//                                             color: Colors.white70,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 16),
//                                       Expanded(
//                                         flex: 3,
//                                         child: Container(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 12),
//                                           decoration: BoxDecoration(
//                                             color: Colors.black,
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             border: Border.all(
//                                               color: Colors.white24,
//                                               width: 1,
//                                             ),
//                                           ),
//                                           child: DropdownButtonHideUnderline(
//                                             child: DropdownButton<String>(
//                                               value:
//                                                   itemControllers[index].text,
//                                               dropdownColor: Color(0xFF1C1C1E),
//                                               style:
//                                                   GoogleFonts.plusJakartaSans(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                               ),
//                                               icon: Icon(Icons.arrow_drop_down,
//                                                   color: Colors.white),
//                                               isExpanded: true,
//                                               items: _proficiencyLevels
//                                                   .map((String level) {
//                                                 return DropdownMenuItem<String>(
//                                                   value: level,
//                                                   child: Text(
//                                                     level,
//                                                     style: GoogleFonts
//                                                         .plusJakartaSans(
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 );
//                                               }).toList(),
//                                               onChanged: (String? newValue) {
//                                                 if (newValue != null) {
//                                                   setState(() {
//                                                     itemControllers[index]
//                                                         .text = newValue;
//                                                   });
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 : TextField(
//                                     controller: itemControllers[index],
//                                     style: GoogleFonts.plusJakartaSans(
//                                         color: Colors.white),
//                                     decoration: InputDecoration(
//                                       labelText: label,
//                                       labelStyle: GoogleFonts.plusJakartaSans(
//                                         color: Colors.white70,
//                                       ),
//                                       filled: true,
//                                       fillColor: Colors.black,
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                         borderSide: BorderSide.none,
//                                       ),
//                                     ),
//                                   ),
//                           );
//                         },
//                       ),
//                     if (title == 'Skills')
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Wrap(
//                             spacing: 8,
//                             runSpacing: 8,
//                             children: (profileDetails[0].keySkillsDetails ?? [])
//                                 .map((skill) {
//                               return Chip(
//                                 label: Text(skill.skillName ?? ''),
//                                 deleteIcon: Icon(Icons.close, size: 16),
//                                 onDeleted: () {
//                                   // Handle skill deletion with API
//                                   setState(() {
//                                     // You'll need to implement API call to delete skill
//                                   });
//                                   Navigator.pop(context);
//                                   _showEditDialog(
//                                       context,
//                                       title,
//                                       content,
//                                       items,
//                                       profileDetails[0]
//                                           .keySkillsDetails
//                                           ?.map((s) => s.skillName.toString())
//                                           .toList(),
//                                       profileDetails);
//                                 },
//                               );
//                             }).toList(),
//                           ),
//                           SizedBox(height: 8),
//                           TextField(
//                             decoration: InputDecoration(
//                               hintText: 'Add new skill',
//                               suffixIcon: IconButton(
//                                 icon: Icon(Icons.add, color: Colors.white),
//                                 onPressed: () {
//                                   final newSkill = textController.text.trim();
//                                   if (newSkill.isNotEmpty) {
//                                     // Handle adding new skill with API
//                                     setState(() {
//                                       // You'll need to implement API call to add skill
//                                     });
//                                     textController.clear();
//                                     Navigator.pop(context);
//                                     _showEditDialog(
//                                         context,
//                                         title,
//                                         content,
//                                         items,
//                                         profileDetails[0]
//                                             .keySkillsDetails
//                                             ?.map((s) => s.skillName.toString())
//                                             .toList(),
//                                         profileDetails);
//                                   }
//                                 },
//                               ),
//                             ),
//                             controller: textController,
//                             style: GoogleFonts.plusJakartaSans(
//                                 color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: Text(
//                             'Cancel',
//                             style: GoogleFonts.plusJakartaSans(
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Save changes based on section using API data
//                             switch (title) {
//                               case 'About':
//                                 _updateContent(title, textController.text);
//                                 break;
//                               case 'Career Preferences':
//                                 final preferences = [
//                                   {
//                                     'PreferredWorkLocation': profileDetails[0]
//                                             .otherDetails?[0]
//                                             .preferredWorkLocation ??
//                                         ''
//                                   },
//                                   {
//                                     'PreferredSalary': profileDetails[0]
//                                             .otherDetails?[0]
//                                             .preferredSalary ??
//                                         ''
//                                   },
//                                   {
//                                     'ResumeHeadline': profileDetails[0]
//                                             .otherDetails?[0]
//                                             .resumeHeadline ??
//                                         ''
//                                   },
//                                 ];

//                                 final newPrefs =
//                                     List<Map<String, String>>.generate(
//                                   preferences.length,
//                                   (index) => {
//                                     preferences[index].keys.first:
//                                         itemControllers[index].text
//                                   },
//                                 );

//                                 // Call API to update career preferences
//                                 _updateContent(title, newPrefs);
//                                 break;
//                               case 'Languages Known':
//                                 final languageList =
//                                     profileDetails[0].languageDetails ?? [];

//                                 final newLangs =
//                                     List<Map<String, String>>.generate(
//                                   languageList.length,
//                                   (index) => {
//                                     languageList[index].language ?? '':
//                                         itemControllers[index].text
//                                   },
//                                 );

//                                 // Call API to update languages
//                                 _updateContent(title, newLangs);
//                                 break;
//                             }
//                             Navigator.pop(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFFCCFF00),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: Text(
//                             'Save',
//                             style: GoogleFonts.plusJakartaSans(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<void> fetchDataFuture;
  String ipAddress = '103.241.225.195';
  String? token;
  UserPreferences userPreference = UserPreferences();
  dynamic UserData1;
  String? profileLogo;
  String? name;
  String? email;
  String? mobile;
  String? workStatus;
  String? currentCity;
  String? aboutUser;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _uploadedFileUrl;

  @override
  void initState() {
    userPreference.getUserData().then((value) {
      setState(() {
        UserData1 = value!;
        token = UserData1['refresh'].toString();
        // profileLogo = UserData1['user']['userProfilePhoto'].toString();
        // name = UserData1['user']['name'].toString();
        email = UserData1['user']['email'].toString();
        // mobile = UserData1['user']['mobile'].toString();
        // workStatus = UserData1['user']['workStatus'].toString();
        // currentCity = UserData1['user']['currentCity'].toString();
        // aboutUser = UserData1['user']['aboutUser'].toString();
        print(' Token : $token');
      });
    });

    super.initState();
    fetchDataFuture = fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(microseconds: 20));
    final profileDetailsViewmodel = Provider.of<ProfileDetailsViewmodel>(
      context,
      listen: false,
    );

    await profileDetailsViewmodel.fetchProfileDetailsApi(
      ipAddress.toString(),
      email.toString(),
      token.toString(),
    );

    final getSkillListViewmodel = Provider.of<GetSkillListViewmodel>(
      context,
      listen: false,
    );

    await getSkillListViewmodel.fetchGetSkillListApi(
      ipAddress.toString(),
      token.toString(),
    );
  }

  final List<String> _proficiencyLevels = [
    'Beginner',
    'Intermediate',
    'Expert',
  ];

  void _updateContent(String section, dynamic newContent) {
    setState(() {
      switch (section) {
        case 'About':
          final editUserAboutInfoViewModel =
              Provider.of<EditUserAboutInfoViewModel>(context, listen: false);
          Map<String, String> data = {"aboutUser": newContent.toString()};

          editUserAboutInfoViewModel.editUserAboutInfoApi(
            ipAddress,
            token.toString(),
            data,
            context,
          );
          // UserData.aboutText = newContent as String;
          break;
        case 'Basic Info':
          final editBasicInfoViewModel =
              Provider.of<EditUserProfileDetailsViewModel>(
                context,
                listen: false,
              );

          //                             Map<String, String> data = {'name':,
          // 'workStatus':
          // };

          editBasicInfoViewModel.editUserProfileDetailsApi(
            ipAddress,
            token.toString(),
            newContent,
            context,
          );
          break;

        case 'Career Preferences':
          final profileDetailsViewmodel = Provider.of<ProfileDetailsViewmodel>(
            context,
            listen: false,
          );

          final editOtherDetailsViewModel =
              Provider.of<EditOtherDetailsViewModel>(context, listen: false);

          print(
            'section  section  section  section  section  section  section  section  section  section  section  ',
          );
          print(section);
          print(newContent);
          print(newContent[0]);

          print(newContent[0]['PreferredWorkLocation']);
          print(
            'section  section  section  section  section  section  section  section  section  section  section  ',
          );

          Map<String, String> data = {
            'otherDetailsId':
                profileDetailsViewmodel
                    .profileDetails
                    .data!
                    .userBasicDetailsList![0]
                    .otherDetails![0]
                    .id
                    .toString(),
            'resumeHeadline': newContent[2]['ResumeHeadline'],
            'preferredWorkLocation': newContent[0]['PreferredWorkLocation'],
            'preferredSalary': newContent[1]['PreferredSalary'],
            'gender':
                profileDetailsViewmodel
                    .profileDetails
                    .data!
                    .userBasicDetailsList![0]
                    .otherDetails![0]
                    .gender
                    .toString(),
          };

          editOtherDetailsViewModel.editOtherDetailsApi(
            ipAddress,
            token.toString(),
            data,
            context,
          );

          // UserData.careerPreferences =
          //     (newContent as List<Map<String, String>>);
          break;
        case 'Skills':
          // UserData.skills = (newContent as List<String>);
          break;
        case 'Languages Known':
          // UserData.languages = List<Map<String, String>>.from(newContent);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileDetailsViewmodel = Provider.of<ProfileDetailsViewmodel>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Color(0xFFCCFF00),
      body: FutureBuilder<void>(
        future: fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else {
            return ChangeNotifierProvider<ProfileDetailsViewmodel>.value(
              value: profileDetailsViewmodel,
              child: Consumer<ProfileDetailsViewmodel>(
                builder: (context, value, _) {
                  switch (value.profileDetails.status!) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(child: Text(value.toString()));
                    case Status.COMPLETED:
                      var profileDetails =
                          value.profileDetails.data!.userBasicDetailsList;

                      print(
                        '222222222222222222222222222222222222222222222222222222222222222222222222',
                      );
                      print(profileDetails![0].userProfilePhoto.toString());
                      print(
                        value
                            .profileDetails
                            .data!
                            .userBasicDetailsList![0]
                            .name,
                      );

                      print(
                        '222222222222222222222222222222222222222222222222222222222222222222222222',
                      );
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            // Fixed Header
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 48,
                              ),
                              color: Color(0xFFCCFF00),
                              child: Column(
                                children: [
                                  Container(
                                    width: 100.w,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            userPreference.logoutProcess();

                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => LoginScreen(),
                                              ),
                                              (route) => false,
                                            );
                                          },
                                          child: Icon(Icons.logout_outlined),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  AdditionalDetailsScreen(),
                                        ),
                                      );
                                    },

                                    //  _pickImage,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 15.h,
                                          height: 15.h,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child:
                                              _imageFile != null
                                                  ? Image.file(
                                                    _imageFile!,
                                                    fit: BoxFit.cover,
                                                  )
                                                  : Image.network(
                                                    profileDetails![0]
                                                        .userProfilePhoto
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                        ),
                                        // Positioned(
                                        //   right: 0,
                                        //   bottom: 0,
                                        //   child: Container(
                                        //     padding: EdgeInsets.all(4),
                                        //     decoration: BoxDecoration(
                                        //       color: Colors.black,
                                        //       shape: BoxShape.circle,
                                        //     ),
                                        //     child: Icon(
                                        //       Icons.edit,
                                        //       color: Color(0xFFCCFF00),
                                        //       size: 16,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  GestureDetector(
                                    onTap:
                                        () => _showBasicInfoDialog(
                                          context,
                                          'Name',
                                          profileDetails[0].name.toString(),
                                          profileDetails,
                                        ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          profileDetails[0].name.toString(),
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        // Icon(
                                        //   Icons.edit_outlined,
                                        //   color: Colors.black.withOpacity(0.7),
                                        //   size: 16,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  GestureDetector(
                                    // onTap: () => _showBasicInfoDialog(
                                    //   context,
                                    //   'Headline',
                                    //   profileDetails[0].workStatus ?? '',
                                    //   profileDetails,
                                    // ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          profileDetails[0].workStatus ?? '',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black.withOpacity(
                                              0.7,
                                            ),
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        // Icon(
                                        //   Icons.edit_outlined,
                                        //   color: Colors.black.withOpacity(0.5),
                                        //   size: 14,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.download,
                                      color: Color(0xFFCCFF00),
                                      size: 18,
                                    ),
                                    label: Text(
                                      'Download Resume',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Color(0xFFCCFF00),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Column(
                              children: [
                                _buildSectionWithBackground(
                                  'About',
                                  profileDetails[0].aboutUser ?? '',
                                  showMore: false,
                                  profileDetails: profileDetails,
                                ),
                                Container(height: 1.5.h, width: 100.w),
                                _buildPreferencesSection(
                                  'CareerPreferences',
                                  [
                                    {
                                      'PreferredWorkLocation':
                                          profileDetails[0]
                                              .otherDetails?[0]
                                              .preferredWorkLocation ??
                                          '',
                                    },
                                    {
                                      'PreferredSalary':
                                          profileDetails[0]
                                              .otherDetails?[0]
                                              .preferredSalary ??
                                          '',
                                    },
                                    {
                                      'ResumeHeadline':
                                          profileDetails[0]
                                              .otherDetails?[0]
                                              .resumeHeadline ??
                                          '',
                                    },
                                  ],
                                  profileDetails: profileDetails,
                                ),
                                Container(height: 1.5.h, width: 100.w),
                                _buildSkillsSection(
                                  'Skills',
                                  profileDetails[0].keySkillsDetails,
                                  profileDetails: profileDetails,
                                ),
                                // _buildLanguagesSection(
                                //   'LanguagesKnown',
                                //   profileDetails[0].languageDetails,
                                //   profileDetails: profileDetails,
                                // ),
                                Container(height: 1.5.h, width: 100.w),

                                _buildProjectSection(),
                                Container(height: 1.5.h, width: 100.w),
                                _buildWorkExperienceSection(),

                                Container(height: 1.5.h, width: 100.w),
                              ],
                            ),
                          ],
                        ),
                      );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }

  // Add this inside the build method where you want to display the project section
  Widget _buildProjectSection() {
    final profileDetailsViewmodel = Provider.of<ProfileDetailsViewmodel>(
      context,
      listen: false,
    );
    var profileDetails =
        profileDetailsViewmodel.profileDetails.data!.userBasicDetailsList![0];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Project',
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xFFCCFF00),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProjectScreen()),
                  );
                },
                child: Text(
                  'Add',
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFFCCFF00),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...profileDetails.projectDetails!
              .map((project) => _buildProjectItem(project))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildProjectItem(ProjectDetails project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              project.name.toString(),
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.edit_outlined,
              color: Colors.white.withOpacity(0.7),
              size: 16,
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          project.description.toString(),
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4),
        SizedBox(height: 16),
      ],
    );
  }

  // Add this inside the build method where you want to display the work experience section
  Widget _buildWorkExperienceSection() {
    final profileDetailsViewmodel = Provider.of<ProfileDetailsViewmodel>(
      context,
      listen: false,
    );
    var profileDetails =
        profileDetailsViewmodel.profileDetails.data!.userBasicDetailsList![0];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Work Experience',
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xFFCCFF00),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddWorkExperienceScreen(),
                    ),
                  );
                },
                child: Text(
                  'Add',
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFFCCFF00),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...profileDetails.employmentDetails!
              .map((employment) => _buildWorkExperienceItem(employment))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildWorkExperienceItem(EmploymentDetails employment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              employment.currentJobTitle.toString(),
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.edit_outlined,
              color: Colors.white.withOpacity(0.7),
              size: 16,
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          employment.companyName.toString(),
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: Colors.white.withOpacity(0.5),
              size: 14,
            ),
            SizedBox(width: 4),
            Text(
              '${employment.fromDuration} - ${employment.toDuration!.isEmpty ? "Present" : employment.toDuration} - ${employment.totalWorkExperienced}',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Colors.white.withOpacity(0.5),
              size: 14,
            ),
            SizedBox(width: 4),
            Text(
              employment.currentCity.toString(),
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _showBasicInfoDialog(
    BuildContext context,
    String field,
    String currentValue,
    List<UserBasicDetailsList> profileDetails,
  ) {
    final TextEditingController textController = TextEditingController(
      text: currentValue,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(0xFF1C1C1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit $field',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: textController,
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter your $field',
                    hintStyle: GoogleFonts.plusJakartaSans(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Update the field based on which field is being edited
                        Map<String, String> data = {};

                        if (field == 'Name') {
                          data['name'] = textController.text;
                        } else if (field == 'Work Status') {
                          data['workStatus'] = textController.text;
                        }

                        _updateContent('Basic Info', data);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFCCFF00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionWithBackground(
    String title,
    String content, {
    bool showMore = false,
    required List<UserBasicDetailsList> profileDetails,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xFFCCFF00),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  _showEditDialog(
                    context,
                    title,
                    content,
                    null,
                    null,
                    profileDetails,
                  );
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: Color(0xFFCCFF00).withOpacity(0.7),
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          Html(
            data: content,
            style: {
              "p": Style(
                color: Colors.white,
                fontSize: FontSize(14),
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                lineHeight: LineHeight(1.5),
              ),
            },
          ),
          // Text(
          //   content,
          //   style: GoogleFonts.plusJakartaSans(
          //     color: Colors.white,
          //     height: 1.5,
          //     fontSize: 14,
          //   ),
          // ),
          if (showMore)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'See more',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection(
    String title,
    List<Map<String, String>> preferences, {
    required List<UserBasicDetailsList> profileDetails,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xFFCCFF00),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  _showEditDialog(
                    context,
                    title,
                    null,
                    null,
                    null,
                    profileDetails,
                  );
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: Color(0xFFCCFF00).withOpacity(0.7),
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...preferences.map(
            (pref) => _buildPreferenceItem(pref.keys.first, pref.values.first),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(
    String title,
    List<KeySkillsDetails>? skills, {
    required List<UserBasicDetailsList> profileDetails,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xFFCCFF00),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  _showEditDialog(
                    context,
                    title,
                    null,
                    null,
                    skills?.map((s) => s.skillName.toString()).toList(),
                    profileDetails,
                  );
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: Color(0xFFCCFF00).withOpacity(0.7),
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                skills!
                    .map((skill) => _buildChip(skill.skillName.toString()))
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguagesSection(
    String title,
    List<LanguageDetails>? languages, {
    required List<UserBasicDetailsList> profileDetails,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xFFCCFF00),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  _showEditDialog(
                    context,
                    title,
                    null,
                    null,
                    null,
                    profileDetails,
                  );
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: Color(0xFFCCFF00).withOpacity(0.7),
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...languages!.map(
            (lang) => _buildLanguageItem(
              lang.language.toString(),
              lang.proficiency.toString(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(String language, String level) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            language,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(width: 16),
          Text(
            level,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 12),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    String title,
    String? content,
    List<Widget>? items,
    List<String>? chips,
    List<UserBasicDetailsList> profileDetails,
  ) {
    final TextEditingController textController = TextEditingController(
      text: content,
    );
    final List<TextEditingController> itemControllers = [];
    print(
      'titletitletitletitletitletitletitletitletitletitletitletitletitletitle',
    );
    print(title);
    print(
      'titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle',
    );
    // For Skills, keep track of selected skills and available skills
    List<String> selectedSkills = [];
    if (title == 'Skills' && profileDetails[0].keySkillsDetails != null) {
      selectedSkills =
          profileDetails[0].keySkillsDetails!
              .map((s) => s.skillName.toString())
              .toList();
    }

    // Initialize controllers based on API data, not static UserData
    if (title == 'Career Preferences') {
      // Use API data for career preferences
      final preferences = [
        {
          'PreferredWorkLocation':
              profileDetails[0].otherDetails?[0].preferredWorkLocation ?? '',
        },
        {
          'PreferredSalary':
              profileDetails[0].otherDetails?[0].preferredSalary ?? '',
        },
        {
          'ResumeHeadline':
              profileDetails[0].otherDetails?[0].resumeHeadline ?? '',
        },
      ];

      for (var pref in preferences) {
        itemControllers.add(TextEditingController(text: pref.values.first));
      }
    } else if (title == 'Languages Known') {
      // Use API data for languages
      for (var lang in profileDetails[0].languageDetails ?? []) {
        String initialValue = lang.proficiency ?? '';
        if (!_proficiencyLevels.contains(initialValue)) {
          initialValue = _proficiencyLevels[0];
        }
        itemControllers.add(TextEditingController(text: initialValue));
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // For Skills dialog, we'll get the full skill list from the viewmodel
        if (title == 'Skills') {
          final getSkillListViewmodel = Provider.of<GetSkillListViewmodel>(
            context,
            listen: false,
          );
          return StatefulBuilder(
            builder: (context, setStateLocal) {
              return Dialog(
                backgroundColor: Color(0xFF1C1C1E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'Edit $title',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Selected Skills Section
                        Text(
                          'Your Skills',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              selectedSkills.map((skillName) {
                                return Chip(
                                  label: Text(
                                    skillName,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  backgroundColor: Colors.black,
                                  deleteIcon: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.white70,
                                  ),
                                  onDeleted: () {
                                    // Remove skill from selected skills
                                    setStateLocal(() {
                                      selectedSkills.remove(skillName);
                                    });
                                  },
                                );
                              }).toList(),
                        ),
                        SizedBox(height: 16),
                        // Add new skill section
                        Text(
                          'Add Skills',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24, width: 1),
                          ),
                          child:
                              getSkillListViewmodel.getSkillList.data == null
                                  ? Center(child: CircularProgressIndicator())
                                  : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        getSkillListViewmodel
                                            .getSkillList
                                            .data!
                                            .keySkillsList!
                                            .length,
                                    itemBuilder: (context, index) {
                                      final skill =
                                          getSkillListViewmodel
                                              .getSkillList
                                              .data!
                                              .keySkillsList![index];
                                      final skillName =
                                          skill.skillName.toString();
                                      final isSelected = selectedSkills
                                          .contains(skillName);

                                      return ListTile(
                                        title: Text(
                                          skillName,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        trailing:
                                            isSelected
                                                ? Icon(
                                                  Icons.check_circle,
                                                  color: Color(0xFFCCFF00),
                                                )
                                                : Icon(
                                                  Icons.add_circle_outline,
                                                  color: Colors.white70,
                                                ),
                                        onTap: () {
                                          setStateLocal(() {
                                            // Toggle selection
                                            if (isSelected) {
                                              selectedSkills.remove(skillName);
                                            } else {
                                              selectedSkills.add(skillName);
                                            }
                                          });
                                        },
                                      );
                                    },
                                  ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                // Call API to update skills with selectedSkills
                                // final updateSkillsViewModel =
                                //     Provider.of<UpdateSkillsViewModel>(context,
                                //         listen: false);
                                List<Map<String, dynamic>> formattedSkills = [];

                                for (String skillName in selectedSkills) {
                                  // Find the skill in keySkillsList by name to get its ID
                                  var matchingSkill = getSkillListViewmodel
                                      .getSkillList
                                      .data!
                                      .keySkillsList!
                                      .firstWhere(
                                        (skill) =>
                                            skill.skillName.toString() ==
                                            skillName,
                                        // orElse: () => null
                                      );

                                  if (matchingSkill != null) {
                                    // Create an object with keySkillsId
                                    formattedSkills.add({
                                      '"keySkillsId"': matchingSkill.id,
                                    });
                                  }
                                }

                                // Create skills data object based on selectedSkills
                                Map<String, String> skillsData = {
                                  'keySkillsArr': formattedSkills.toString(),
                                };
                                print(selectedSkills);

                                print(
                                  'skillsDataskillsDataskillsDataskillsDataskillsDataskillsDataskillsData',
                                );
                                print(skillsData);

                                print(
                                  'skillsDataskillsDataskillsDataskillsDataskillsDataskillsDataskillsData',
                                );
                                // ???
                                final updateKeySkillViewModel =
                                    Provider.of<UpdateKeySkillViewModel>(
                                      context,
                                      listen: false,
                                    );

                                // // Call update skill API
                                updateKeySkillViewModel.updateKeySkillApi(
                                  ipAddress,
                                  token.toString(),
                                  skillsData,
                                  context,
                                );

                                // Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFCCFF00),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Save',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          // Original dialog implementation for other edit types

          return Dialog(
            backgroundColor: Color(0xFF1C1C1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Edit $title',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (content != null)
                      TextField(
                        controller: textController,
                        style: GoogleFonts.plusJakartaSans(color: Colors.white),
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Enter your $title',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    if (title == 'Career Preferences' ||
                        title == 'Languages Known')
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: itemControllers.length,
                        itemBuilder: (context, index) {
                          String label;
                          if (title == 'Career Preferences') {
                            final preferences = [
                              {
                                'PreferredWorkLocation':
                                    profileDetails[0]
                                        .otherDetails?[0]
                                        .preferredWorkLocation ??
                                    '',
                              },
                              {
                                'PreferredSalary':
                                    profileDetails[0]
                                        .otherDetails?[0]
                                        .preferredSalary ??
                                    '',
                              },
                              {
                                'ResumeHeadline':
                                    profileDetails[0]
                                        .otherDetails?[0]
                                        .resumeHeadline ??
                                    '',
                              },
                            ];
                            label = preferences[index].keys.first;
                          } else {
                            label =
                                profileDetails[0]
                                    .languageDetails?[index]
                                    .language ??
                                '';
                          }

                          return Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child:
                                title == 'Languages Known'
                                    ? Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            label,
                                            style: GoogleFonts.plusJakartaSans(
                                              color: Colors.white70,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.white24,
                                                width: 1,
                                              ),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value:
                                                    itemControllers[index].text,
                                                dropdownColor: Color(
                                                  0xFF1C1C1E,
                                                ),
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.white,
                                                ),
                                                isExpanded: true,
                                                items:
                                                    _proficiencyLevels.map((
                                                      String level,
                                                    ) {
                                                      return DropdownMenuItem<
                                                        String
                                                      >(
                                                        value: level,
                                                        child: Text(
                                                          level,
                                                          style:
                                                              GoogleFonts.plusJakartaSans(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                onChanged: (String? newValue) {
                                                  if (newValue != null) {
                                                    setState(() {
                                                      itemControllers[index]
                                                          .text = newValue;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                    : TextField(
                                      controller: itemControllers[index],
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: label,
                                        labelStyle: GoogleFonts.plusJakartaSans(
                                          color: Colors.white70,
                                        ),
                                        filled: true,
                                        fillColor: Colors.black,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                          );
                        },
                      ),
                    if (title == 'Skills')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                (profileDetails[0].keySkillsDetails ?? []).map((
                                  skill,
                                ) {
                                  return Chip(
                                    label: Text(skill.skillName ?? ''),
                                    deleteIcon: Icon(Icons.close, size: 16),
                                    onDeleted: () {
                                      // Handle skill deletion with API
                                      setState(() {
                                        // You'll need to implement API call to delete skill
                                      });
                                      Navigator.pop(context);
                                      _showEditDialog(
                                        context,
                                        title,
                                        content,
                                        items,
                                        profileDetails[0].keySkillsDetails
                                            ?.map((s) => s.skillName.toString())
                                            .toList(),
                                        profileDetails,
                                      );
                                    },
                                  );
                                }).toList(),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Add new skill',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  final newSkill = textController.text.trim();
                                  if (newSkill.isNotEmpty) {
                                    // Handle adding new skill with API
                                    setState(() {
                                      // You'll need to implement API call to add skill
                                    });
                                    textController.clear();
                                    Navigator.pop(context);
                                    _showEditDialog(
                                      context,
                                      title,
                                      content,
                                      items,
                                      profileDetails[0].keySkillsDetails
                                          ?.map((s) => s.skillName.toString())
                                          .toList(),
                                      profileDetails,
                                    );
                                  }
                                },
                              ),
                            ),
                            controller: textController,
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Save changes based on section using API data
                            switch (title) {
                              case 'About':
                                _updateContent(title, textController.text);
                                break;
                              case 'Career Preferences':
                                final preferences = [
                                  {
                                    'PreferredWorkLocation':
                                        profileDetails[0]
                                            .otherDetails?[0]
                                            .preferredWorkLocation ??
                                        '',
                                  },
                                  {
                                    'PreferredSalary':
                                        profileDetails[0]
                                            .otherDetails?[0]
                                            .preferredSalary ??
                                        '',
                                  },
                                  {
                                    'ResumeHeadline':
                                        profileDetails[0]
                                            .otherDetails?[0]
                                            .resumeHeadline ??
                                        '',
                                  },
                                ];

                                final newPrefs =
                                    List<Map<String, String>>.generate(
                                      preferences.length,
                                      (index) => {
                                        preferences[index].keys.first:
                                            itemControllers[index].text,
                                      },
                                    );

                                // Call API to update career preferences
                                _updateContent(title, newPrefs);
                                break;
                              case 'Languages Known':
                                final languageList =
                                    profileDetails[0].languageDetails ?? [];

                                final newLangs =
                                    List<Map<String, String>>.generate(
                                      languageList.length,
                                      (index) => {
                                        languageList[index].language ?? '':
                                            itemControllers[index].text,
                                      },
                                    );

                                // Call API to update languages
                                _updateContent(title, newLangs);
                                break;
                            }
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFCCFF00),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
