import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:skillmoraskh_app/Data/Response/status.dart';
import 'package:skillmoraskh_app/Res/app_url.dart';
import 'package:skillmoraskh_app/SharedPreferences/sharePreference.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/EditUserProfileDetails/editUserProfileDetails_view_model.dart';
import 'package:skillmoraskh_app/View_Model/Profile_View_Model/GetProfileDetails/profile_view_model.dart';

class EditProfileDetailsScreen extends StatefulWidget {
  @override
  _EditProfileDetailsScreenState createState() =>
      _EditProfileDetailsScreenState();
}

class _EditProfileDetailsScreenState extends State<EditProfileDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final headLineController = TextEditingController();
  final nameController = TextEditingController();
  final mobileNoController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final currentCityController = TextEditingController();

  String _selectedStatus = 'Not Started';
  DateTime? _startDate;
  DateTime? _endDate;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _uploadedFileUrl;
  String ipAddress = '103.241.225.195';
  String? token;
  UserPreferences userPreference = UserPreferences();
  dynamic UserData1;
  String? email;
  late Future<void> fetchDataFuture;

  List<String> statusOptions = ['Not Started', 'In Progress', 'Finished'];
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
    final profileDetailsViewmodel =
        Provider.of<ProfileDetailsViewmodel>(context, listen: false);

    await profileDetailsViewmodel.fetchProfileDetailsApi(
        ipAddress.toString(), email.toString(), token.toString());
  }

  @override
  void dispose() {
    headLineController.dispose();
    nameController.dispose();
    mobileNoController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFFCCFF00),
              onPrimary: Colors.black,
              surface: Color(0xFF1C1C1E),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text = DateFormat('MMM dd, yyyy').format(picked);
        } else {
          _endDate = picked;
          _endDateController.text = DateFormat('MMM dd, yyyy').format(picked);
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      // Upload image immediately
      await _uploadPdfToServer(_imageFile!);
    }
  }

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
          final editBasicInfoViewModel =
              Provider.of<EditUserProfileDetailsViewModel>(context,
                  listen: false);

          Map<String, String> data = {
            'userProfilePhoto': _uploadedFileUrl.toString(),
          };

          editBasicInfoViewModel.editUserProfileDetailsApi(
              ipAddress, token.toString(), data, context);
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

  @override
  Widget build(BuildContext context) {
    final profileDetailsViewmodel =
        Provider.of<ProfileDetailsViewmodel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Edit Profile Details',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                          '222222222222222222222222222222222222222222222222222222222222222222222222');
                      print(profileDetails![0].userProfilePhoto.toString());
                      print(value
                          .profileDetails.data!.userBasicDetailsList![0].name);
                      nameController.text = profileDetails[0].name.toString();
                      headLineController.text =
                          profileDetails[0].workStatus.toString();
                      mobileNoController.text =
                          profileDetails[0].mobile.toString();
                      currentCityController.text =
                          profileDetails[0].currentCity.toString();
                      print(
                          '222222222222222222222222222222222222222222222222222222222222222222222222');
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: _pickImage,

                                        //  _pickImage,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 15.h,
                                              height: 15.h,
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                shape: BoxShape.circle,
                                              ),
                                              clipBehavior: Clip.hardEdge,
                                              child: _imageFile != null
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
                                    ],
                                  ),
                                ),
                                _buildLabel('Name'),
                                _buildTextField(
                                  controller: nameController,
                                  hintText: 'Enter a Name',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                _buildLabel('HeadLine'),
                                _buildTextField(
                                  controller: headLineController,
                                  hintText: 'Enter a HeadLine',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter HeadLine';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                _buildLabel('MobileNo'),
                                _buildTextField(
                                  controller: mobileNoController,
                                  hintText: 'Enter a MobileNo',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter MobileNo';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                _buildLabel('Current City'),
                                _buildTextField(
                                  controller: currentCityController,
                                  hintText: 'Enter a Current City',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Current City';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 40),
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        final editBasicInfoViewModel = Provider
                                            .of<EditUserProfileDetailsViewModel>(
                                                context,
                                                listen: false);

                                        Map<String, String> data = {
                                          'name': nameController.text,
                                          'workStatus': headLineController.text,
                                          'mobile': mobileNoController.text,
                                          'currentCity':
                                              currentCityController.text,
                                              'status': 'profile'
                                        };

                                        editBasicInfoViewModel
                                            .editUserProfileDetailsApi(
                                                ipAddress,
                                                token.toString(),
                                                data,
                                                context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFCCFF00),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      'Save And Continue',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white.withOpacity(0.7),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.plusJakartaSans(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: Colors.white.withOpacity(0.3),
        ),
        filled: true,
        fillColor: Color(0xFF1C1C1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedStatus,
          isExpanded: true,
          dropdownColor: Color(0xFF1C1C1E),
          style: GoogleFonts.plusJakartaSans(color: Colors.white),
          items: statusOptions.map((String status) {
            return DropdownMenuItem<String>(
              value: status,
              child: Text(status),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedStatus = newValue;
                // Clear dates if status changes
                if (newValue == 'Not Started') {
                  _startDateController.clear();
                  _endDateController.clear();
                  _startDate = null;
                  _endDate = null;
                }
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildDateField(bool isStartDate) {
    return TextFormField(
      controller: isStartDate ? _startDateController : _endDateController,
      readOnly: true,
      style: GoogleFonts.plusJakartaSans(color: Colors.white),
      decoration: InputDecoration(
        hintText: isStartDate ? 'Select Start Date' : 'Select End Date',
        hintStyle: GoogleFonts.plusJakartaSans(
          color: Colors.white.withOpacity(0.3),
        ),
        filled: true,
        fillColor: Color(0xFF1C1C1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onTap: () => _selectDate(context, isStartDate),
    );
  }
}
