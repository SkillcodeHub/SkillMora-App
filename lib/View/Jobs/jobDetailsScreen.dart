import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/Routes/routes_name.dart';
import 'aboutCompanyScreen.dart';

class JobDetailsScreen extends StatefulWidget {
  final dynamic data;

  JobDetailsScreen({
    super.key,
    required this.data,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  String? selectedButton;
  // final String location = 'Remote';
  // final String experience = '2-4 years exp.';

  @override
  void initState() {
    super.initState();
  }

  String _parseHtmlContent(String input) {
    try {
      // Remove outer quotes if present
      String processedInput =
          input.startsWith('"') ? input.substring(1, input.length - 1) : input;

      // Unescape the HTML content
      processedInput = processedInput.replaceAll('\\"', '"');

      return processedInput;
    } catch (e) {
      print('Error parsing HTML content: $e');
      return input;
    }
  }

  Widget _buildDescription(String description, Color textColor) {
    final htmlContent = _parseHtmlContent(description);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Html(
                data: htmlContent,
                style: {
                  "body": Style(
                    fontSize: FontSize(14),
                    color: textColor.withOpacity(0.9),
                    lineHeight: LineHeight(1.5),
                    // Remove textOverflow to show complete content
                    // fontFamily: 'PlusJakartaSans',
                    margin: Margins.zero,
                  ),
                  "p": Style(
                    margin: Margins.zero,
                  ),
                },
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSpotifyCard =
        widget.data['company'].toLowerCase() == 'spotify';
    final Color textColor = isSpotifyCard ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Job Details',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboutCompanyScreen(
                                  companyId: widget.data['companyId'],
                                ),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF1C1C1E),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.info_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: widget.data['color'],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                width: 5.h,
                                height: 5.h,
                                // padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                clipBehavior: Clip.hardEdge,

                                child: Image.network(
                                  widget.data['companyLogo'],
                                  fit: BoxFit
                                      .cover, // Change from contain to cover
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              
                              
                                          
                                          SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 69.w,
                                                child: Text(
                                                  widget.data['role'],
                                                  style:
                                                      GoogleFonts.plusJakartaSans(
                                                    color: textColor,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 69.w,
                                                child: Text(
                                                  widget.data['company'],
                                                  style:
                                                      GoogleFonts.plusJakartaSans(
                                                    color: textColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        children: [
                                          _buildChip(
                                              widget.data['location'],
                                              Icons.location_on_outlined,
                                              textColor),
                                          SizedBox(width: 8),
                                          _buildChip(widget.data['experience'],
                                              Icons.school_outlined, textColor),
                                          SizedBox(width: 8),
                                          _buildChip(widget.data['jobType'],
                                              Icons.work_outline, textColor),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.access_time,
                                              color: Colors.black, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            widget.data['formattedDate'],
                                            style: GoogleFonts.plusJakartaSans(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        widget.data['salary'],
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          _buildSection(
                            'Job Description',
                            Icons.edit_note,
                            widget.data['description'],
                          ),
                          SizedBox(height: 24),
                          _buildRequirementsSection(),
                          // SizedBox(height: 24),
                          // _buildSection(
                          //   'Your Role',
                          //   Icons.person_outline,
                          //   'As a UX Designer, you will be directly responsible for helping define and create intuitive, innovative, and delightful user experiences for our customers.',
                          // ),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, String content) {
    final bool isLightColor = widget.data['color'].computeLuminance() > 0.5;

    final Color textColor =  Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          _buildDescription(content, textColor)
          // Padding(
          //   padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          //   child: Text(
          //     content,
          //     style: GoogleFonts.plusJakartaSans(
          //       color: Colors.grey[400],
          //       height: 1.5,
          //       fontSize: 14,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildRequirementsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text(
                  'Skills & Requirements',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                _buildRequirement(widget.data['keyQualifications']),
                // _buildRequirement(
                //     'Degree in Computer Science, Psychology, Design or any other related fields'),
                // _buildRequirement(
                //     'Proficiency in User Personas, Competitive Analysis, Empathy Maps and Information Architecture'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirement(String jsonText) {
    // Parse the JSON string
    List<dynamic> requirements = [];
    try {
      String cleanJson = jsonText.replaceAll(r'\"', '"');
      requirements = json.decode(cleanJson);
    } catch (e) {
      print('Error parsing JSON: $e');
      return SizedBox();
    }

    // Changed Row to Wrap widget
    return Wrap(
      spacing: 8, // Horizontal spacing between items
      runSpacing: 8, // Vertical spacing between lines
      crossAxisAlignment: WrapCrossAlignment.start,
      children: requirements.map((requirement) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: EdgeInsets.only(bottom: 4), // Added margin for better spacing
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.12),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                requirement['label'] ?? '',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChip(String label, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0),
              Colors.black.withOpacity(0.8),
              Colors.black,
            ],
            stops: [0.0, 0.5, 0.8],
          ),
        ),
        padding: EdgeInsets.all(16),
        child: selectedButton == 'apply'
            ? SizedBox(
                width: double.infinity,
                height: 55,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 23, 46, 255),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cancel Application',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: selectedButton == 'save'
                                      ? Color.fromARGB(255, 23, 46, 255)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        selectedButton == 'save'
                                            ? Icons.bookmark
                                            : Icons.bookmark_outline,
                                        color: selectedButton == 'save'
                                            ? Colors.white
                                            : Colors.black87,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        selectedButton == 'save'
                                            ? 'Unsave'
                                            : 'Save',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: selectedButton == 'save'
                                              ? Colors.white
                                              : Colors.black87,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 9,
                            width: 28,
                            margin: EdgeInsets.symmetric(horizontal: 1),
                            color: Colors.white,
                            alignment: Alignment.center,
                          ),
                          Expanded(
                            flex: 4,
                            child: GestureDetector(
                              onTap: () {
                                Map data = {
                                  'jobId': widget.data['jobId'],
                                };
                                Navigator.pushNamed(
                                    context, RoutesName.applyJobScreen,
                                    arguments: data);
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: selectedButton == 'apply'
                                      ? Color.fromARGB(255, 23, 46, 255)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Apply Now',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: selectedButton == 'apply'
                                            ? Colors.white
                                            : Colors.black87,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: selectedButton == 'apply'
                                          ? Colors.white
                                          : Colors.black87,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
