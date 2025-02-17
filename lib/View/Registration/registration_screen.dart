import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Res/app_url.dart';
import '../../View_Model/Auth_view_Model/registerUser_view_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../View_Model/Auth_view_Model/sendOtp_view_model.dart';
import '../OtpVerify/otpVerifyScreen.dart';

class SkillmoraRegistration extends StatefulWidget {
  const SkillmoraRegistration({Key? key}) : super(key: key);

  @override
  State<SkillmoraRegistration> createState() => _SkillmoraRegistrationState();
}

class _SkillmoraRegistrationState extends State<SkillmoraRegistration> {
  String? _selectedWorkStatus;
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  String? _uploadedFileUrl;

  TextEditingController nameStr = TextEditingController();
  TextEditingController emailStr = TextEditingController();
  TextEditingController passwordStr = TextEditingController();
  TextEditingController mobileStr = TextEditingController();
  TextEditingController cityStr = TextEditingController();
  File? _selectedResume;

  // Email validation regex
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void initState() {
    super.initState();
    // Add listeners to all controllers to check form validity
    nameStr.addListener(_validateForm);
    emailStr.addListener(_validateForm);
    passwordStr.addListener(_validateForm);
    mobileStr.addListener(_validateForm);
    cityStr.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      bool basicFieldsValid = _formKey.currentState?.validate() ?? false;
      bool resumeValid =
          _selectedWorkStatus == 'experienced' ? _selectedResume != null : true;
      _isFormValid =
          basicFieldsValid && resumeValid && _selectedWorkStatus != null;
    });
  }

  Future<bool> _handleStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      // Opens app settings if permission is permanently denied
      await openAppSettings();
      return false;
    }

    status = await Permission.storage.request();
    return status.isGranted;
  }

  // New function to upload PDF to server
  Future<void> _uploadPdfToServer(File pdfFile) async {
    try {
      var uri = Uri.parse(AppUrl.uploadResumeUrl);

      var request = http.MultipartRequest('POST', uri);
      var pdfStream = http.ByteStream(pdfFile.openRead());
      var length = await pdfFile.length();

      var multipartFile = http.MultipartFile(
          'media', // form field name
          pdfStream,
          length,
          filename: pdfFile.path.split('/').last);

      request.files.add(multipartFile);

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseData);

      if (jsonResponse['status'] == true) {
        setState(() {
          _uploadedFileUrl = jsonResponse['uploadedURL'];
        });
      } else {
        throw Exception('Failed to upload file');
      }
    } catch (e) {
      print('Error uploading file: $e');
      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Error'),
            content: Text('Failed to upload the file. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _pickResume() async {
    try {
      bool hasPermission = await _handleStoragePermission();

      if (!hasPermission) {
        // Show dialog when permission is denied
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Required'),
              content: Text(
                  'Storage permission is required to pick files. Would you like to grant permission?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await openAppSettings();
                  },
                  child: Text('Open Settings'),
                ),
              ],
            );
          },
        );
        return;
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        setState(() {
          _selectedResume = file;
        });

        // Upload the PDF file immediately after selection
        await _uploadPdfToServer(file);
        _validateForm();
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  void dispose() {
    nameStr.dispose();
    emailStr.dispose();
    passwordStr.dispose();
    mobileStr.dispose();
    cityStr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sendOtpViewModel = Provider.of<SendOtpViewModel>(context);

    return Scaffold(
      backgroundColor: Color(0xFFCC1E602),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: SafeArea(
            child: Form(
              key: _formKey,
              onChanged: _validateForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_rounded,
                          color: Colors.black87)),
                  SizedBox(height: 2.h),
                  Container(
                    width: 70.w,
                    child: Text(
                      'Create your Skillmora profile',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F2937),
                              ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Search & apply to jobs from India\'s No.1 Job Site',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32),

                  // Full Name
                  _buildInputLabel('Full Name'),
                  _buildTextField(
                    controller: nameStr,
                    hintText: 'Enter a Full Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),

                  // Email ID
                  _buildInputLabel('Email ID'),
                  _buildTextField(
                    controller: emailStr,
                    hintText: 'Tell us your Email ID',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  _buildHelperText(
                      'We\'ll send relevant jobs and updates to this email'),
                  SizedBox(height: 24),

                  // Password
                  _buildInputLabel('Password'),
                  _buildTextField(
                    controller: passwordStr,
                    hintText: '(Minimum 6 characters)',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  _buildHelperText('This helps your account stay protected'),
                  SizedBox(height: 24),

                  // Mobile Number
                  _buildInputLabel('Mobile number'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '+91',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildTextField(
                          controller: mobileStr,
                          hintText: 'Enter your mobile number',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            if (value.length != 10) {
                              return 'Mobile number must be exactly 10 digits';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Please enter only numbers';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  _buildHelperText(
                      'Recruiters will contact you on this number'),
                  SizedBox(height: 24),

                  // Work Status
                  Row(
                    children: [
                      _buildInputLabel('Work Status'),
                      SizedBox(width: 4),
                      Text('*', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        value: _selectedWorkStatus,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: InputBorder.none,
                        ),
                        hint: Text(
                          'Select Work Status',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'fresher',
                            child: Text('Fresher'),
                          ),
                          DropdownMenuItem(
                            value: 'experienced',
                            child: Text('Experienced'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your work status';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _selectedWorkStatus = value;
                            _selectedResume =
                                null; // Reset resume when status changes
                            _validateForm();
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Conditional Resume Upload
                  if (_selectedWorkStatus != null) ...[
                    _buildInputLabel('Resume'),
                    if (_selectedWorkStatus == 'experienced')
                      Text('*', style: TextStyle(color: Colors.red)),
                    GestureDetector(
                      onTap: _pickResume,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.upload_file, size: 32),
                            SizedBox(height: 8),
                            Text(
                              _selectedResume != null
                                  ? 'Selected: ${_selectedResume!.path.split('/').last}'
                                  : 'Choose File to upload',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Files Supported: PDF',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_selectedWorkStatus == 'experienced' &&
                        _selectedResume == null)
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'Resume is required for experienced candidates',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    SizedBox(height: 24),

                    // Current City
                    _buildInputLabel('Current City'),
                    _buildTextField(
                      controller: cityStr,
                      hintText: 'Tell us a Current City',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your current city';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                  ],

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:

                          // () {
                          //   Map data = {
                          //     'email': emailStr.text,
                          //   };
                          //   sendOtpViewModel.sendOtpApi(data, context);

                          //   // Navigator.push(
                          //   //     context,
                          //   //     MaterialPageRoute(
                          //   //         builder: (context) => OtpVerificationScreen()));
                          // }
// _isFormValid
//                             ? () {
//                                 if (_formKey.currentState!.validate()) {
//                                   print(
//                                       'Form is valid, proceeding with registration');
//                                   Map data = {
//                                     'name': nameStr.text,
//                                     'email': emailStr.text,
//                                     'password': passwordStr.text,
//                                     'mobile': mobileStr.text,
//                                     'workStatus':
//                                         _selectedWorkStatus.toString(),
//                                     'currentCity': cityStr.text,
//                                     'resumeFile': _uploadedFileUrl.toString(),
//                                   };
//                                   sendOtpViewModel.sendOtpApi(data, context);

//                                   // registerViewModel.registerUserApi(
//                                   //     data, context);
//                                 }
//                               }
//                             : null;
                          _isFormValid
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    print(
                                        'Form is valid, proceeding with registration');
                                    Map data = {
                                      'name': nameStr.text,
                                      'email': emailStr.text,
                                      'password': passwordStr.text,
                                      'mobile': mobileStr.text,
                                      'workStatus':
                                          _selectedWorkStatus.toString(),
                                      'currentCity': cityStr.text,
                                      'resumeFile': _uploadedFileUrl.toString(),
                                    };
                                    sendOtpViewModel.sendOtpApi(data, context);
                                    // registerViewModel.registerUserApi(
                                    //     data, context);
                                  }
                                }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.yellow,
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

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController? controller,
    required String hintText,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        errorStyle: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildHelperText(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
