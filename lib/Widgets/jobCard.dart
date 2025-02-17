import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../Utils/Routes/routes_name.dart';

String getTimeAgo(String dateString) {
  try {
    final DateTime date = DateTime.parse(dateString);
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);

    if (difference.inDays > 365) {
      final int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final int months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  } catch (e) {
    return dateString; // Return original string if parsing fails
  }
}

String formatSalary(String salary) {
  try {
    // Split the salary string into amount and period
    final parts = salary.toLowerCase().split(' per ');
    if (parts.length != 2) return salary;

    final amount = double.parse(parts[0].replaceAll(RegExp(r'[^0-9.]'), ''));
    final period = parts[1].toLowerCase();

    // Format amount
    String formattedAmount;
    if (amount >= 1000000) {
      formattedAmount = '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      formattedAmount = '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      formattedAmount = amount.toStringAsFixed(0);
    }

    // Format period
    String formattedPeriod;
    switch (period) {
      case 'hour':
        formattedPeriod = '/Hr';
        break;
      case 'month':
        formattedPeriod = '/mo';
        break;
      case 'year':
        formattedPeriod = '/yr';
        break;
      default:
        formattedPeriod = '/${period[0]}';
    }

    return '$formattedAmount$formattedPeriod';
  } catch (e) {
    return salary; // Return original string if formatting fails
  }
}

class JobCard extends StatelessWidget {
  final String company;
  final String role;
  final String location;
  final String experience;
  final String jobType;
  final String description;
  final String salary;
  final Color color;
  final VoidCallback? onRemove;
  final String? removeText;
  final String postedDate;
  final String keyQualifications;
  final String jobId;
  final String companyLogo;
  final String companyId;

  const JobCard({
    super.key,
    required this.company,
    required this.role,
    required this.location,
    required this.experience,
    required this.jobType,
    required this.description,
    required this.salary,
    required this.color,
    required this.postedDate,
    required this.keyQualifications,
    this.onRemove,
    this.removeText,
    required this.jobId,
    required this.companyLogo,
    required this.companyId,
  });

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 72, // Approximately 3 lines of text
          child: Html(
            data: htmlContent,
            style: {
              "body": Style(
                fontSize: FontSize(14),
                color: textColor.withOpacity(0.9),
                lineHeight: LineHeight(1.5),
                maxLines: 3,
                textOverflow: TextOverflow.ellipsis,
                fontFamily: 'PlusJakartaSans',
                margin: Margins.zero,
                // padding: EdgeInsets.all(0),
              ),
              "p": Style(
                margin: Margins.zero,
                // padding: EdgeInsets.zero,
              ),
            },
            shrinkWrap: true,
          ),
        ),
        TextButton(
          onPressed: () {
            // Handle "Read More" action
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Read More',
            style: GoogleFonts.plusJakartaSans(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate if the background is light or dark
    final bool isLightColor = color.computeLuminance() > 0.5;
    final Color textColor = isLightColor ? Colors.black : Colors.white;
    final String formattedDate = getTimeAgo(postedDate);
    final String formattedSalary = formatSalary(salary);

    return Column(
      children: [
        Stack(
          children: [
            ClipPath(
              clipper: CardClipper(),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  companyLogo,
                                  fit: BoxFit
                                      .cover, // Change from contain to cover
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              
                              
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50.w,
                                    child: Text(
                                      role.split(' ').length > 1
                                          ? role.split(' ').take(1).join(' ') +
                                              '\n' +
                                              role.split(' ').skip(1).join(' ')
                                          : role,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: textColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    width: 60.w,
                                    child: Text(
                                      company,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: textColor.withOpacity(0.9),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildChip(location, Icons.location_on_outlined,
                                    textColor),
                                SizedBox(width: 2),
                                _buildChip(experience, Icons.school_outlined,
                                    textColor),
                                SizedBox(width: 2),
                                _buildChip(jobType, Icons.access_time_outlined,
                                    textColor),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildDescription(description, textColor),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                color: Colors.black,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Posted $formattedDate",
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            formattedSalary,
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  Map data = {
                    "color": color,
                    "company": company,
                    "role": role,
                    "location": location,
                    "experience": experience.toString(),
                    "jobType": jobType.toString(),
                    "salary": formattedSalary,
                    "description": description,
                    "formattedDate": formattedDate,
                    "keyQualifications": keyQualifications,
                    "jobId": jobId,
                    "companyLogo": companyLogo,
                    "companyId": companyId,
                  };

                  Navigator.pushNamed(
                    context,
                    RoutesName.JobDetails,
                    arguments: data,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 27, 27, 40),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 14),
                      Icon(
                        Icons.arrow_outward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (onRemove != null)
          Padding(
            padding: EdgeInsets.only(top: 4, bottom: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRemove,
                icon: Icon(
                  removeText?.contains('Unsave') ?? false
                      ? Icons.bookmark_remove
                      : Icons.close,
                  size: 20,
                  color: color,
                ),
                label: Text(
                  removeText ?? 'Remove',
                  style: GoogleFonts.plusJakartaSans(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  side: BorderSide(color: color, width: 2),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
      ],
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
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Adjustable values
    double radius = 24;
    double cutStartX = size.width - 155;
    double cutEndX = size.width;
    double cutHeight = 75;

    // Start path
    path.moveTo(radius, 0);
    path.lineTo(cutStartX - 20, 0);

    // Initial curve and steep fall
    path.cubicTo(
      cutStartX - 10,
      0,
      cutStartX + 27,
      cutHeight * 0.1,
      cutStartX + 26,
      cutHeight * 0.5,
    );

    // Continue steep fall
    path.cubicTo(
      cutStartX + 25,
      cutHeight * 0.7,
      cutStartX + 25,
      cutHeight * 0.95,
      cutStartX + 65,
      cutHeight * 0.98,
    );

    // Horizontal curve to edge
    path.cubicTo(
      cutStartX + 80,
      cutHeight * 0.98,
      cutStartX + 120,
      cutHeight * 0.99,
      cutEndX - 40,
      cutHeight * 0.99,
    );

    // Ultra-smooth connection to edge with gentle curve
    path.cubicTo(
      cutEndX - 25, cutHeight * 0.99,
      cutEndX - 10, cutHeight * 1.09, // Slight rise for smoothness
      cutEndX, cutHeight * 1.55, // Gentle curve up to meet the edge
    );

    // Back to normal card edge
    path.lineTo(cutEndX, size.height - radius);
    path.arcToPoint(
      Offset(cutEndX - radius, size.height),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(0, radius);
    path.arcToPoint(
      Offset(radius, 0),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
