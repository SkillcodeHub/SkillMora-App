import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Data/Response/status.dart';
import '../../SharedPreferences/sharePreference.dart';
import '../../View_Model/Jobs_View_Model/appliedJobs_view_model.dart';

class AppliedJobsListScreen extends StatefulWidget {
  AppliedJobsListScreen({super.key});

  @override
  State<AppliedJobsListScreen> createState() => _AppliedJobsListScreenState();
}

class _AppliedJobsListScreenState extends State<AppliedJobsListScreen> {
  String? token;
  UserPreferences userPreference = UserPreferences();
  dynamic UserData;
  String ipAddress = '103.241.225.195';
  late Future<void> fetchDataFuture;

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
    fetchDataFuture = fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(microseconds: 20));
    final getAppliedJobsListViewmodel =
        Provider.of<GetAppliedJobsListViewmodel>(context, listen: false);

    getAppliedJobsListViewmodel.fetchAppliedJobsListApi(
        ipAddress.toString(), token.toString());
  }

  @override
  Widget build(BuildContext context) {
    final getAppliedJobsListViewmodel =
        Provider.of<GetAppliedJobsListViewmodel>(context, listen: false);
    final appliedJobs = 'e'; // Use the model getter

    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else {
            return ChangeNotifierProvider<GetAppliedJobsListViewmodel>.value(
              value: getAppliedJobsListViewmodel,
              child: Consumer<GetAppliedJobsListViewmodel>(
                builder: (context, value, _) {
                  switch (value.getAppliedJobsList.status!) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Text(value.toString());
                    case Status.COMPLETED:
                    print('value.getAppliedJobsList        value.getAppliedJobsList        value.getAppliedJobsList        value.getAppliedJobsList        ');
                    print(value.getAppliedJobsList);

                    print('value.getAppliedJobsList        value.getAppliedJobsList        value.getAppliedJobsList        value.getAppliedJobsList        value.getAppliedJobsList        ');
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
                                    icon: Icon(Icons.arrow_back,
                                        color: Colors.white),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Jobs You Applied',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Search Bar
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Color(0xFF1C1C1E),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.search, color: Colors.white54),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Devops!',
                                          hintStyle:
                                              GoogleFonts.plusJakartaSans(
                                            color: Colors.white54,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          // Implement search functionality if needed
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Results Text
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Results',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            // Applied Jobs List
                            Expanded(
                              child: appliedJobs.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No applied jobs yet',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      itemCount: value.getAppliedJobsList.data!
                                          .appliedJobs!.length,
                                      itemBuilder: (context, index) {
                                        final job = value.getAppliedJobsList
                                            .data!.appliedJobs![index];
                                        return _buildJobCard(
                                          job.jobDetails!.jobTitle!.toString(),
                                          job.jobDetails!.companyDetails!
                                              .companyName
                                              .toString(),
                                          job.createdAt.toString(),
                                          job.jobDetails!.employmentType!
                                              .courseTypeName
                                              .toString(),
                                          job.status.toString(),
job.jobDetails!.companyDetails!.companyLogo.toString()
                                              
                                              ,
                                        );
                                      },
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

  String _getCompanyLogo(String company) {
    switch (company.toLowerCase()) {
      case 'google':
        return 'assets/icons/google-178-svgrepo-com.svg';
      case 'airbnb':
        return 'assets/icons/airbnb-179-svgrepo-com.svg';
      case 'spotify':
        return 'assets/icons/spotify-svgrepo-com.svg';
      case 'microsoft':
        return 'assets/icons/microsoft-svgrepo-com.svg';
      case 'apple':
        return 'assets/icons/apple-inc-svgrepo-com.svg';
      default:
        return 'assets/icons/google-178-svgrepo-com.svg'; // Default logo
    }
  }

  // String? _getApplicationStatus(int index) {
  //   // Mock status logic - you can implement real status tracking
  //   if (index == 0) return 'Reviewing';
  //   if (index == 3) return 'Rejected';
  //   return null;
  // }

  // bool _isApplicationRejected(int index) {
  //   return index == 3;
  // }

  Widget _buildJobCard(
    String role,
    String company,
    String timeAgo,
    String type,
    String status,
    String logoPath) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Company Logo
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
                                  logoPath,
                                  fit: BoxFit
                                      .cover, // Change from contain to cover
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              
          SizedBox(width: 12),

          // Job Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  company,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildSpecChip(
                      timeAgo,
                      Icons.access_time_outlined,
                    ),
                    _buildSpecChip(
                      type,
                      Icons.work_outline,
                    ),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: status == ""
                              ? Colors.red.withOpacity(0.2)
                              : Color(0xFFFFB800).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.plusJakartaSans(
                            color: status == ""? Colors.red : Color(0xFFFFB800),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white54,
            size: 14,
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
