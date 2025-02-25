import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:skillmoraskh_app/Data/Response/status.dart';
import 'package:skillmoraskh_app/Models/ProfileDetails_Model/profileDetails_model.dart';
import 'package:skillmoraskh_app/SharedPreferences/sharePreference.dart'
    show UserPreferences;
import 'package:skillmoraskh_app/View/Profile/editProfiledetailsScreen.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/EditOtherDetails_View_Model/editOtherDetails_view_model.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/EditUserAboutInfo/editUserAboutInfo_view_model.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/EditUserProfileDetails/editUserProfileDetails_view_model.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/GetProfileDetails/profile_view_model.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  AdditionalDetailsScreen({super.key});

  @override
  State<AdditionalDetailsScreen> createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _uploadedFileUrl;
  String ipAddress = '103.241.225.195';
  String? token;
  UserPreferences userPreference = UserPreferences();
  dynamic UserData1;
  String? email;
  late Future<void> fetchDataFuture;

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
      backgroundColor: Colors.black,
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
                      return SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Additional Details',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 48,
                              ),
                              color: Color(0xFFCCFF00),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  EditProfileDetailsScreen(),
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
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.edit,
                                              color: Color(0xFFCCFF00),
                                              size: 16,
                                            ),
                                          ),
                                        ),
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  GestureDetector(
                                    onTap:
                                        () => _showBasicInfoDialog(
                                          context,
                                          'Headline',
                                          profileDetails[0].workStatus ?? '',
                                          profileDetails,
                                        ),
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ),

                            // Content
                            Expanded(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSection(
                                      'Education',
                                      Icons.school_outlined,
                                      onAdd: () => _showEducationDialog(),
                                    ),
                                    SizedBox(height: 24),
                                    _buildSection(
                                      'Languages Known',
                                      Icons.language_outlined,
                                      onAdd: () => _showLanguageDialog(),
                                    ),
                                    SizedBox(height: 24),
                                    _buildSection(
                                      'Courses & Certificates',
                                      Icons.card_membership_outlined,
                                      onAdd: () => _showCertificateDialog(),
                                    ),
                                  ],
                                ),
                              ),
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

  Widget _buildSection(
    String title,
    IconData icon, {
    required VoidCallback onAdd,
  }) {
    return GestureDetector(
      onTap: () => _showSectionDetails(title),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: Color(0xFFCCFF00), size: 2.h),
                    ),
                    SizedBox(width: 12),
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        color: Color(0xFFCCFF00),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFFCCFF00),
                      ),
                      onPressed: onAdd,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white54,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSectionDetails(String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder:
                (_, controller) => Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Handle bar
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      // Title
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      // Content
                      Expanded(
                        child: ListView(
                          controller: controller,
                          padding: EdgeInsets.all(16),
                          children: _getContentForSection(title),
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  List<Widget> _getContentForSection(String title) {
    switch (title) {
      case 'Education':
        return UserData.education.map((edu) => _buildDetailCard(edu)).toList();
      case 'Languages Known':
        return UserData.languages
            .map((lang) => _buildLanguageCard(lang))
            .toList();
      case 'Courses & Certificates':
        return UserData.certificates
            .map((cert) => _buildCertificateCard(cert))
            .toList();
      default:
        return [];
    }
  }

  Widget _buildDetailCard(Map<String, dynamic> edu) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  edu['education'] ?? '',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    '${edu['startDuration']} - ${edu['endDuration']}',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.edit, color: Color(0xFFCCFF00), size: 20),
                    onPressed: () => _showEducationDialog(education: edu),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed:
                        () => _showDeleteConfirmation(context, 'Education', () {
                          setState(() {
                            UserData.education.remove(edu);
                          });
                          _showSectionDetails('Education');
                        }),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            '${edu['course']} - ${edu['specification']}',
            style: GoogleFonts.plusJakartaSans(
              color: Color(0xFFCCFF00),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'University: ${edu['university']}\n' +
                'Course Type: ${edu['courseType']}\n' +
                '${edu['gradingSystem']}: ${edu['marks']}',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(Map<String, String> lang) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lang.keys.first,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFCCFF00).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  lang.values.first,
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFFCCFF00),
                    fontSize: 14,
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(Icons.edit, color: Color(0xFFCCFF00), size: 20),
                onPressed: () => _showLanguageDialog(language: lang),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(Icons.delete_outline, color: Colors.red, size: 20),
                onPressed:
                    () => _showDeleteConfirmation(context, 'Language', () {
                      setState(() {
                        UserData.languages.remove(lang);
                      });
                      _showSectionDetails('Languages Known');
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard(Map<String, dynamic> cert) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  cert['title'] ?? '',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    cert['expiryDate'] ?? '',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.edit, color: Color(0xFFCCFF00), size: 20),
                    onPressed: () => _showCertificateDialog(certificate: cert),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed:
                        () =>
                            _showDeleteConfirmation(context, 'Certificate', () {
                              setState(() {
                                UserData.certificates.remove(cert);
                              });
                              _showSectionDetails('Courses & Certificates');
                            }),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            cert['issuer'] ?? '',
            style: GoogleFonts.plusJakartaSans(
              color: Color(0xFFCCFF00),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          if (cert['url'] != null && cert['url'].isNotEmpty)
            Text(
              cert['url'],
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          if (cert['isExpired'] != null)
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color:
                    cert['isExpired'] == 'Yes'
                        ? Colors.red.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                cert['isExpired'] == 'Yes' ? 'Expired' : 'Active',
                style: GoogleFonts.plusJakartaSans(
                  color: cert['isExpired'] == 'Yes' ? Colors.red : Colors.green,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showEducationDialog({Map<String, dynamic>? education}) {
    final educationController = TextEditingController(
      text: education?['education'],
    );
    final courseController = TextEditingController(text: education?['course']);
    final courseTypeController = TextEditingController(
      text: education?['courseType'],
    );
    final specificationController = TextEditingController(
      text: education?['specification'],
    );
    final universityController = TextEditingController(
      text: education?['university'],
    );
    final startDurationController = TextEditingController(
      text: education?['startDuration'],
    );
    final endDurationController = TextEditingController(
      text: education?['endDuration'],
    );
    final marksController = TextEditingController(text: education?['marks']);
    String selectedGradingSystem = education?['gradingSystem'] ?? 'CGPA';

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
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
                    Text(
                      education == null ? 'Add Education' : 'Edit Education',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Education Dropdown
                    DropdownButtonFormField<String>(
                      value: education?['education'],
                      hint: Text(
                        'Select Education',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white54,
                        ),
                      ),
                      items:
                          ['B.Tech', 'M.Tech', 'BCA', 'MCA', 'BSc', 'MSc'].map((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          educationController.text = newValue ?? '';
                        });
                      },
                      style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      dropdownColor: Color(0xFF1C1C1E),
                      decoration: _getDropdownDecoration('Education'),
                    ),
                    SizedBox(height: 12),
                    // Course Dropdown
                    DropdownButtonFormField<String>(
                      value: education?['course'],
                      hint: Text(
                        'Select Course',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white54,
                        ),
                      ),
                      items:
                          [
                            'Computer Science',
                            'Information Technology',
                            'Electronics',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          courseController.text = newValue ?? '';
                        });
                      },
                      style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      dropdownColor: Color(0xFF1C1C1E),
                      decoration: _getDropdownDecoration('Course'),
                    ),
                    SizedBox(height: 12),
                    // Course Type Dropdown
                    DropdownButtonFormField<String>(
                      value: education?['courseType'],
                      hint: Text(
                        'Select Course Type',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white54,
                        ),
                      ),
                      items:
                          ['Full Time', 'Part Time', 'Distance Learning'].map((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          courseTypeController.text = newValue ?? '';
                        });
                      },
                      style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      dropdownColor: Color(0xFF1C1C1E),
                      decoration: _getDropdownDecoration('Course Type'),
                    ),
                    SizedBox(height: 12),
                    // Specification Dropdown
                    DropdownButtonFormField<String>(
                      value: education?['specification'],
                      hint: Text(
                        'Select Specification',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white54,
                        ),
                      ),
                      items:
                          ['Software Engineering', 'Data Science', 'AI/ML'].map(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          specificationController.text = newValue ?? '';
                        });
                      },
                      style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      dropdownColor: Color(0xFF1C1C1E),
                      decoration: _getDropdownDecoration('Specification'),
                    ),
                    SizedBox(height: 12),
                    // University Dropdown
                    DropdownButtonFormField<String>(
                      value: education?['university'],
                      hint: Text(
                        'Select University',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white54,
                        ),
                      ),
                      items:
                          ['University 1', 'University 2', 'University 3'].map((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          universityController.text = newValue ?? '';
                        });
                      },
                      style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      dropdownColor: Color(0xFF1C1C1E),
                      decoration: _getDropdownDecoration('University'),
                    ),
                    SizedBox(height: 12),
                    // Start Duration
                    _buildTextField('Start Duration', startDurationController),
                    SizedBox(height: 12),
                    // End Duration
                    _buildTextField('End Duration', endDurationController),
                    SizedBox(height: 12),
                    // Grading System Dropdown
                    DropdownButtonFormField<String>(
                      value: selectedGradingSystem,
                      items:
                          ['CGPA', 'Percentage', 'Grade'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGradingSystem = newValue!;
                        });
                      },
                      style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      dropdownColor: Color(0xFF1C1C1E),
                      decoration: _getDropdownDecoration('Grading System'),
                    ),
                    SizedBox(height: 12),
                    // Marks Input
                    _buildTextField('Enter Marks', marksController),
                    SizedBox(height: 24),
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
                        SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            final newEducation = {
                              'education': educationController.text,
                              'course': courseController.text,
                              'courseType': courseTypeController.text,
                              'specification': specificationController.text,
                              'university': universityController.text,
                              'startDuration': startDurationController.text,
                              'endDuration': endDurationController.text,
                              'gradingSystem': selectedGradingSystem,
                              'marks': marksController.text,
                            };

                            setState(() {
                              if (education == null) {
                                UserData.education.add(newEducation);
                              } else {
                                final index = UserData.education.indexOf(
                                  education,
                                );
                                UserData.education[index] = newEducation;
                              }
                            });
                            Navigator.pop(context);
                            _showSectionDetails('Education');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFCCFF00),
                          ),
                          child: Text(
                            education == null ? 'Save' : 'Update',
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
          ),
    );
  }

  void _showLanguageDialog({Map<String, String>? language}) {
    final languageController = TextEditingController(
      text: language?.keys.first,
    );
    String selectedProficiency = language?.values.first ?? 'Beginner';

    showDialog(
      context: context,
      builder:
          (BuildContext dialogContext) => StatefulBuilder(
            builder:
                (BuildContext context, StateSetter dialogSetState) => Dialog(
                  backgroundColor: Color(0xFF1C1C1E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Languages Known',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(dialogContext),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        _buildTextField('Language', languageController),
                        SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: selectedProficiency,
                          items:
                              ['Beginner', 'Intermediate', 'Expert'].map((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            dialogSetState(() {
                              selectedProficiency = newValue!;
                            });
                          },
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                          ),
                          dropdownColor: Color(0xFF1C1C1E),
                          decoration: _getDropdownDecoration('Proficiency'),
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFCCFF00),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (languageController.text.isNotEmpty) {
                                final newLanguage = {
                                  languageController.text: selectedProficiency,
                                };

                                setState(() {
                                  if (language == null) {
                                    UserData.languages.add(newLanguage);
                                  } else {
                                    final index = UserData.languages.indexOf(
                                      language,
                                    );
                                    UserData.languages[index] = newLanguage;
                                  }
                                });
                                Navigator.pop(dialogContext);
                                _showSectionDetails('Languages Known');
                              }
                            },
                            child: Text(
                              'Save And Continue',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  void _showCertificateDialog({Map<String, dynamic>? certificate}) {
    final certificateNameController = TextEditingController(
      text: certificate?['title'],
    );
    final certificateUrlController = TextEditingController(
      text: certificate?['url'],
    );
    final issueByController = TextEditingController(
      text: certificate?['issuer'],
    );
    final expiryDateController = TextEditingController(
      text: certificate?['expiryDate'],
    );
    String? isCertificateExpired = certificate?['isExpired'];
    String? selectedFile = certificate?['certificateImage'];

    showDialog(
      context: context,
      builder:
          (BuildContext dialogContext) => StatefulBuilder(
            builder:
                (BuildContext context, StateSetter dialogSetState) => Dialog(
                  backgroundColor: Color(0xFF1C1C1E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  certificate == null
                                      ? 'Add Certificate'
                                      : 'Edit Certificate',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                icon: Icon(Icons.close, color: Colors.white),
                                onPressed: () => Navigator.pop(dialogContext),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          // Certificate Name
                          _buildTextField(
                            'Certificate Name',
                            certificateNameController,
                            required: true,
                          ),
                          SizedBox(height: 12),
                          // Certificate URL
                          _buildTextField(
                            'Certificate Url',
                            certificateUrlController,
                          ),
                          SizedBox(height: 12),
                          // Issue By
                          _buildTextField(
                            'Issue By',
                            issueByController,
                            required: true,
                          ),
                          SizedBox(height: 12),
                          // Is Certificate Expired
                          DropdownButtonFormField<String>(
                            value: isCertificateExpired,
                            hint: Text(
                              'Is Certificate Expired ?',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white54,
                              ),
                            ),
                            items:
                                ['Yes', 'No'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              dialogSetState(() {
                                isCertificateExpired = newValue;
                              });
                            },
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                            ),
                            dropdownColor: Color(0xFF1C1C1E),
                            decoration: _getDropdownDecoration(''),
                          ),
                          SizedBox(height: 12),
                          // Expiry Date
                          _buildTextField(
                            'Expiry Date',
                            expiryDateController,
                            required: true,
                          ),
                          SizedBox(height: 16),
                          // Certificate Image
                          Text(
                            'Certificate Image',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          StatefulBuilder(
                            builder:
                                (context, setState) => GestureDetector(
                                  onTap: () {
                                    // TODO: Implement file picker
                                    setState(() {
                                      selectedFile = 'selected_file.pdf';
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white24,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.file_upload_outlined,
                                          color: Colors.white54,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          selectedFile ??
                                              'Choose File to upload',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Files Supported: PDF, JPG, PNG',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 24),
                          // Save Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFCCFF00),
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                if (certificateNameController.text.isNotEmpty &&
                                    issueByController.text.isNotEmpty &&
                                    expiryDateController.text.isNotEmpty) {
                                  final newCertificate = {
                                    'title': certificateNameController.text,
                                    'url': certificateUrlController.text,
                                    'issuer': issueByController.text,
                                    'isExpired': isCertificateExpired,
                                    'expiryDate': expiryDateController.text,
                                    'certificateImage': selectedFile,
                                  };

                                  setState(() {
                                    if (certificate == null) {
                                      UserData.certificates.add(newCertificate);
                                    } else {
                                      final index = UserData.certificates
                                          .indexOf(certificate);
                                      UserData.certificates[index] =
                                          newCertificate;
                                    }
                                  });
                                  Navigator.pop(dialogContext);
                                  _showSectionDetails('Courses & Certificates');
                                }
                              },
                              child: Text(
                                certificate == null ? 'Save' : 'Update',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            if (required)
              Text(
                ' *',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          style: GoogleFonts.plusJakartaSans(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  InputDecoration _getDropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.plusJakartaSans(color: Colors.white70),
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    String title,
    VoidCallback onDelete,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Color(0xFF1C1C1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Delete $title?',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'This action cannot be undone.',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 24),
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
                      SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onDelete();
                        },
                        child: Text(
                          'Delete',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
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
}

class UserData {
  static String userName = 'Vishnu Prajapati';
  static String aboutText =
      'Passionate software developer with expertise in mobile app development using Flutter and native Android. Strong problem-solving skills and experience in creating user-friendly applications.';

  static List<Map<String, String>> careerPreferences = [
    {'Preferred Work Location': 'Vadodara'},
    {'Preferred Salary': '2,80,000 / Annum'},
    {'Resume Headline': 'Full Stack Developer'},
  ];

  static List<String> skills = ['Javascript', 'HTML5', 'CSS'];

  static List<Map<String, String>> languages = [
    {'English': 'Expert'},
    {'Hindi': 'Expert'},
  ];

  // Add Project data
  static List<Map<String, dynamic>> projects = [
    {
      'title': 'Job Portal App',
      'description':
          'A mobile application for job seekers built with Flutter and Firebase',
      'duration': 'Jan 2024 - Present',
      'technologies': ['Flutter', 'Firebase', 'Provider'],
      'link': 'github.com/username/job-portal',
    },
    {
      'title': 'E-commerce Platform',
      'description': 'Full-stack web application with React and Node.js',
      'duration': 'Aug 2023 - Dec 2023',
      'technologies': ['React', 'Node.js', 'MongoDB'],
      'link': 'github.com/username/ecommerce',
    },
  ];

  // Add Work Experience data
  static List<Map<String, dynamic>> workExperience = [
    {
      'role': 'Software Engineer Intern',
      'company': 'Google',
      'duration': 'Summer 2023',
      'location': 'Mountain View, CA',
      'description':
          'Worked on Android development team to implement new features and improve app performance.',
      'achievements': [
        'Improved app performance by 40%',
        'Implemented new UI components',
        'Collaborated with design team',
      ],
    },
    {
      'role': 'Frontend Developer',
      'company': 'Microsoft',
      'duration': 'Jan 2023 - June 2023',
      'location': 'Remote',
      'description': 'Developed and maintained web applications using React.',
      'achievements': [
        'Led team of 3 developers',
        'Reduced loading time by 50%',
        'Implemented responsive design',
      ],
    },
  ];

  // Add these new data structures to UserData class
  static List<Map<String, dynamic>> education = [
    {
      'degree': 'Computer Science',
      'institution': 'Stanford University',
      'year': '2019 - 2023',
      'grade': 'CGPA: 3.8/4.0',
    },
    {
      'degree': 'High School',
      'institution': 'Lincoln High School',
      'year': '2015 - 2019',
      'grade': 'Major: Science',
    },
  ];

  static List<Map<String, dynamic>> certificates = [
    {
      'title': 'AWS Certified Developer',
      'issuer': 'Amazon Web Services',
      'date': 'Jan 2023',
      'url': 'aws.com/cert/123',
    },
    {
      'title': 'Flutter Development',
      'issuer': 'Google',
      'date': 'Mar 2023',
      'url': 'google.com/cert/456',
    },
  ];
}
