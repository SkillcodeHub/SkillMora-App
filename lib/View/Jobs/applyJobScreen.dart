import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../SharedPreferences/sharePreference.dart';
import '../../View_Model/Jobs_View_Model/applyJob_view_model.dart';
import '../../View_Model/Jobs_View_Model/filterjobs_view_model.dart';
import 'applicationSuccess.dart';

class ApplyJobScreen extends StatefulWidget {
  final dynamic data;

  ApplyJobScreen({
    super.key,
    required this.data,
  });

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _portfolioController = TextEditingController();
  final _coverLetterController = TextEditingController();
  String? _selectedResume;
  bool _isUploading = false;
  String ipAddress = '103.241.225.195';
  String? token;
  UserPreferences userPreference = UserPreferences();
  dynamic UserData;


    @override
  void initState() {
    userPreference.getUserData().then((value) {
      setState(() {
        UserData = value!;
        token = UserData['refresh'].toString();
        print(' Token : $token');
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final applyJobViewModel =
        Provider.of<ApplyJobViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Apply Job',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Full Name'),
                                SizedBox(height: 8),
                                _buildTextField(
                                  controller: _fullNameController,
                                  hint: 'Enter your full name',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 24),
                                _buildLabel('Portfolio'),
                                SizedBox(height: 8),
                                _buildTextField(
                                  controller: _portfolioController,
                                  hint: 'Enter portfolio URL',
                                ),
                                SizedBox(height: 24),
                                _buildLabel('Cover Letter'),
                                SizedBox(height: 8),
                                _buildTextField(
                                  controller: _coverLetterController,
                                  hint: 'Write your cover letter',
                                  maxLines: 5,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please write a cover letter';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 24),
                                _buildLabel('Upload Resume'),
                                SizedBox(height: 8),
                                _buildResumeUploader(),
                                SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Apply Button
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){

                            Map<String, String> data = {
      "jobId": widget.data['jobId'].toString(),
      "coverLetter": _coverLetterController.text,
    };
    applyJobViewModel.applyJobApi(ipAddress.toString(), token.toString(),data, context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4A3AFF),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Apply Now',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.plusJakartaSans(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: Colors.white.withOpacity(0.5),
        ),
        filled: true,
        fillColor: Colors.black,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5),
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5),
            width: 0.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildResumeUploader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: _pickResume,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedResume ?? 'No file chosen',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    if (_selectedResume != null)
                      Text(
                        '320 KB',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              if (_isUploading)
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickResume() async {
    setState(() {
      _selectedResume = 'Vishnu Prajapati CV.pdf';
    });
  }

  
}
