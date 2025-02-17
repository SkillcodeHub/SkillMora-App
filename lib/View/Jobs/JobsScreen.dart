import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Data/Response/status.dart';
import '../../SharedPreferences/sharePreference.dart';
import '../../View_Model/Jobs_View_Model/appliedJobs_view_model.dart';
import '../../View_Model/Jobs_View_Model/filterjobs_view_model.dart';
import '../../View_Model/Jobs_View_Model/savedJobs_view_model.dart';
import '../../Widgets/jobCard.dart';

// jobs_screen.dart
class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  String selectedFilter = 'Discover';
  final TextEditingController _searchController = TextEditingController();
  late Future<void> fetchDataFuture;
  String clientId = '1';
  String ipAddress = '103.241.225.195';
  String limit = '10';
  String offset = '0';
  String? token;
  String ? userName;
  UserPreferences userPreference = UserPreferences();
  dynamic UserData;
  final List<Color> jobCardColors = [
    Color(0xFF5B4DFF),
    Color(0xFFFF385C),
    Color(0xFFFFB100),
  ];
  Timer? _debounce;
  List<dynamic> filteredSavedJobs = [];
  List<dynamic> filteredAppliedJobs = [];
  List<dynamic> filteredClosedJobs = [];

    @override
  void initState() {
    userPreference.getUserData().then((value) {
      setState(() {
        UserData = value!;
        token = UserData['refresh'].toString();
        userName = UserData['user']['name'].toString();
        print(' Token : $token');
      });
    });    super.initState();
    fetchDataFuture = fetchData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Call API with search query
      _performSearch(_searchController.text);
    });
  }

  void _performSearch(String query) {
    Map<String, String> data = {
      "jobTitle": query.trim(), // Search query
      "jobType": "",
      "city": "",
      "salary": "",
      "employementType": ""
    };

    final filterJobsViewmodel =
        Provider.of<FilterJobsViewmodel>(context, listen: false);
    filterJobsViewmodel.fetchFilterJobsApi(limit, offset, clientId.toString(),
        ipAddress.toString(), data, token.toString());
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(microseconds: 20));
    Map<String, String> data = {
      "jobTitle": "",
      "jobType": "",
      "city": "",
      "salary": "",
      "employementType": ""

// "sortingType": ""
      //       "jobTitle": "Full Stack Intern",
      // "jobType": "On-Site",
      // "city": "Vadodara",
      // "salary": "0-3",
      // "employementType": "[3,1]"
    };

    final filterJobsViewmodel =
        Provider.of<FilterJobsViewmodel>(context, listen: false);
    filterJobsViewmodel.fetchFilterJobsApi(limit, offset, clientId.toString(),
        ipAddress.toString(), data, token.toString());

    final getSavedJobsListViewmodel =
        Provider.of<GetSavedJobsListViewmodel>(context, listen: false);
    getSavedJobsListViewmodel.fetchSavedJobsListApi(
        ipAddress.toString(), token.toString());

    final getAppliedJobsListViewmodel =
        Provider.of<GetAppliedJobsListViewmodel>(context, listen: false);

    getAppliedJobsListViewmodel.fetchAppliedJobsListApi(
        ipAddress.toString(), token.toString());
  }

  // @override
  // void dispose() {
  //   _searchController.dispose();
  //   super.dispose();
  // }

  void _onFilterTap(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;

    // Get count based on filter type
    int count = 0;
    switch (label) {
      case 'Discover':
        count = 0;
        break;
      case 'Saved':
        count = 1;
        break;
      case 'Applied':
        count = 2;
        break;
      case 'Closed':
        count = 3;
        break;
    }

    return GestureDetector(
      onTap: () => _onFilterTap(label),
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF4A3AFF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filterJobsViewmodel =
        Provider.of<FilterJobsViewmodel>(context, listen: false);
    final getSavedJobsListViewmodel =
        Provider.of<GetSavedJobsListViewmodel>(context, listen: false);
    final getAppliedJobsListViewmodel =
        Provider.of<GetAppliedJobsListViewmodel>(context, listen: false);

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
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Hello ${userName} ',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                              TextSpan(
                                text: '👋',
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.person_outline_rounded),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Find Jobs',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip('Discover'),
                          _buildDivider(),
                          _buildFilterChip('Saved'),
                          _buildDivider(),
                          _buildFilterChip('Applied'),
                          _buildDivider(),
                          _buildFilterChip('Closed'),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    if (selectedFilter == "Discover")
                      Container(
                        height: 48,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Color(0xFF1C1C1E),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search for company...',
                                  hintStyle: GoogleFonts.plusJakartaSans(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  suffixIcon: _searchController.text.isNotEmpty
                                      ? IconButton(
                                          icon: Icon(Icons.clear,
                                              color: Colors.white54),
                                          onPressed: () {
                                            _searchController.clear();
                                            // Reset search when cleared
                                            _performSearch("");
                                          },
                                        )
                                      : null,
                                ),
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            // Container(
                            //   padding: EdgeInsets.all(8),
                            //   decoration: BoxDecoration(
                            //     color: Color(0xFF2C2C2E),
                            //     borderRadius: BorderRadius.circular(8),
                            //   ),
                            //   child:
                            //       Icon(Icons.tune, color: Colors.white, size: 18),
                            // ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          switch (selectedFilter) {
                            case 'Discover':
                              return ChangeNotifierProvider<
                                  FilterJobsViewmodel>.value(
                                value: filterJobsViewmodel,
                                child: Consumer<FilterJobsViewmodel>(
                                  builder: (context, value, _) {
                                    switch (value.filterJobsList.status!) {
                                      case Status.LOADING:
                                        return Center(
                                            child: CircularProgressIndicator());
                                      case Status.ERROR:
                                        return Text(value.toString());
                                      case Status.COMPLETED:
                                        return _buildJobsList(
                                          value.filterJobsList.data!
                                              .companyJobsList!,
                                        );
                                    }
                                  },
                                ),
                              );

                            case 'Saved':
                              return ChangeNotifierProvider<
                                  GetSavedJobsListViewmodel>.value(
                                value: getSavedJobsListViewmodel,
                                child: Consumer<GetSavedJobsListViewmodel>(
                                  builder: (context, value, _) {
                                    switch (value.getSavedJobsList.status!) {
                                      case Status.LOADING:
                                        return Center(
                                            child: CircularProgressIndicator());
                                      case Status.ERROR:
                                        return Text(value.toString());
                                      case Status.COMPLETED:

//

                                        return value.getSavedJobsList.data!
                                                .userSavedJobs!.isEmpty
                                            ? Center(
                                                child: Text(
                                                  'No jobs found',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color: Colors.white54,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount: value
                                                    .getSavedJobsList
                                                    .data!
                                                    .userSavedJobs!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  final job = value
                                                      .getSavedJobsList
                                                      .data!
                                                      .userSavedJobs![index];
                                                  return JobCard(
                                                    company: job
                                                        .jobDetails!
                                                        .companyDetails!
                                                        .companyName
                                                        .toString(),
                                                    role: job
                                                        .jobDetails!.jobTitle
                                                        .toString(),
                                                    location: job
                                                        .jobDetails!.jobCity!
                                                        .toString(),
                                                    experience: '',
                                                    jobType: job
                                                        .jobDetails!
                                                        .employmentType!
                                                        .courseTypeName
                                                        .toString(),
                                                    description: job.jobDetails!
                                                        .jobDescription
                                                        .toString(),
                                                    salary: job
                                                            .jobDetails!.amount
                                                            .toString() +
                                                        " " +
                                                        job.jobDetails!.payRate
                                                            .toString(),
                                                    color: jobCardColors
                                                        .getColorForIndex(
                                                            index),
                                                    postedDate: job
                                                        .jobDetails!.createdAt
                                                        .toString(),
                                                    keyQualifications: job
                                                        .jobDetails!
                                                        .keyQualifications
                                                        .toString(),
                                                    jobId: job.jobDetails!.id
                                                        .toString(),
                                                    companyLogo: job
                                                        .jobDetails!
                                                        .companyDetails!
                                                        .companyLogo
                                                        .toString(),
                                                    companyId: job
                                                        .jobDetails!
                                                        .companyDetails!
                                                        .companyId
                                                        .toString(),
                                                  );
                                                },
                                              );
                                    }
                                  },
                                ),
                              );

                            case 'Applied':
                              return ChangeNotifierProvider<
                                  GetAppliedJobsListViewmodel>.value(
                                value: getAppliedJobsListViewmodel,
                                child: Consumer<GetAppliedJobsListViewmodel>(
                                  builder: (context, value, _) {
                                    switch (value.getAppliedJobsList.status!) {
                                      case Status.LOADING:
                                        return Center(
                                            child: CircularProgressIndicator());
                                      case Status.ERROR:
                                        return Text(value.toString());
                                      case Status.COMPLETED:
                                        return value.getAppliedJobsList.data!
                                                .appliedJobs!.isEmpty
                                            ? Center(
                                                child: Text(
                                                  'No jobs found',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color: Colors.white54,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount: value
                                                    .getAppliedJobsList
                                                    .data!
                                                    .appliedJobs!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  final job = value
                                                      .getAppliedJobsList
                                                      .data!
                                                      .appliedJobs![index];
                                                  return JobCard(
                                                    company: job
                                                        .jobDetails!
                                                        .companyDetails!
                                                        .companyName
                                                        .toString(),
                                                    role: job
                                                        .jobDetails!.jobTitle!
                                                        .toString(),
                                                    location: job
                                                        .jobDetails!.jobCity!
                                                        .toString(),
                                                    experience: '',
                                                    jobType: job
                                                        .jobDetails!
                                                        .employmentType!
                                                        .courseTypeName
                                                        .toString(),
                                                    description: job.jobDetails!
                                                        .jobDescription
                                                        .toString(),
                                                    salary: job
                                                            .jobDetails!.amount
                                                            .toString() +
                                                        " " +
                                                        job.jobDetails!.payRate
                                                            .toString(),
                                                    color: jobCardColors
                                                        .getColorForIndex(
                                                            index),
                                                    postedDate: job.createdAt
                                                        .toString(),
                                                    keyQualifications: job
                                                        .jobDetails!
                                                        .keyQualifications
                                                        .toString(),
                                                    jobId: job.jobDetails!.id
                                                        .toString(),
                                                    companyLogo: job
                                                        .jobDetails!
                                                        .companyDetails!
                                                        .companyLogo
                                                        .toString(),
                                                    companyId: job
                                                        .jobDetails!
                                                        .companyDetails!
                                                        .companyId
                                                        .toString(),
                                                  );
                                                },
                                              );
                                    }
                                  },
                                ),
                              );

                            case 'Closed':
                              return ChangeNotifierProvider<
                                  GetSavedJobsListViewmodel>.value(
                                value: getSavedJobsListViewmodel,
                                child: Consumer<GetSavedJobsListViewmodel>(
                                  builder: (context, value, _) {
                                    switch (value.getSavedJobsList.status!) {
                                      case Status.LOADING:
                                        return Center(
                                            child: CircularProgressIndicator());
                                      case Status.ERROR:
                                        return Text(value.toString());
                                      case Status.COMPLETED:
                                        return value.getSavedJobsList.data!
                                                .userSavedJobs!.isEmpty
                                            ? Center(
                                                child: Text(
                                                  'No jobs found',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color: Colors.white54,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount: value
                                                    .getSavedJobsList
                                                    .data!
                                                    .userSavedJobs!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  final job = value
                                                      .getSavedJobsList
                                                      .data!
                                                      .userSavedJobs![index];
                                                  return job.jobDetails!
                                                              .isActive
                                                              .toString() !=
                                                          "Active"
                                                      ? JobCard(
                                                          company: job
                                                              .jobDetails!
                                                              .companyDetails!
                                                              .companyName
                                                              .toString(),
                                                          role: job.jobDetails!
                                                              .jobTitle
                                                              .toString(),
                                                          location: job
                                                              .jobDetails!
                                                              .jobCity!
                                                              .toString(),
                                                          experience: '',
                                                          jobType: job
                                                              .jobDetails!
                                                              .employmentType!
                                                              .courseTypeName
                                                              .toString(),
                                                          description: job
                                                              .jobDetails!
                                                              .jobDescription
                                                              .toString(),
                                                          salary: job
                                                                  .jobDetails!
                                                                  .amount
                                                                  .toString() +
                                                              " " +
                                                              job.jobDetails!
                                                                  .payRate
                                                                  .toString(),
                                                          color: jobCardColors
                                                              .getColorForIndex(
                                                                  index),
                                                          postedDate: job
                                                              .jobDetails!
                                                              .createdAt
                                                              .toString(),
                                                          keyQualifications: job
                                                              .jobDetails!
                                                              .keyQualifications
                                                              .toString(),
                                                          jobId: job
                                                              .jobDetails!.id
                                                              .toString(),
                                                          companyLogo: job
                                                              .jobDetails!
                                                              .companyDetails!
                                                              .companyLogo
                                                              .toString(),
                                                          companyId: job
                                                              .jobDetails!
                                                              .companyDetails!
                                                              .companyId
                                                              .toString(),
                                                        )
                                                      : Center(
                                                          child: Text(
                                                            'No jobs found',
                                                            style: GoogleFonts
                                                                .plusJakartaSans(
                                                              color: Colors
                                                                  .white54,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        );
                                                },
                                              );
                                    }
                                  },
                                ),
                              );

                            default:
                              return Center(
                                  child: Text('Invalid filter selected'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildJobsList(List companyJobsList) {
    return companyJobsList.isEmpty
        ? Center(
            child: Text(
              'No jobs found',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white54,
                fontSize: 16,
              ),
            ),
          )
        : ListView.builder(
            itemCount: companyJobsList.length,
            itemBuilder: (context, index) {
              final job = companyJobsList[index];
              return JobCard(
                company: job.companyDetails!.companyName.toString(),
                role: job.jobTitle!.toString(),
                location: job.jobCity!.toString(),
                experience: job.requiredExperience!.toString(),
                jobType: job.employmentTypeDetails.courseTypeName.toString(),
                description: job.jobDescription.toString(),
                salary: job.amount.toString() + " " + job.payRate.toString(),
                color: jobCardColors.getColorForIndex(index),
                postedDate: job.createdAt.toString(),
                keyQualifications: job.keyQualifications.toString(),
                jobId: job.id.toString(),
                companyLogo: job.companyDetails!.companyLogo.toString(),
                companyId: job.companyDetails!.id.toString(),
              );
            },
          );
  }

  Widget _buildDivider() {
    return Container(
      height: 9,
      width: 20,
      margin: EdgeInsets.symmetric(horizontal: 0),
      color: Colors.white,
      alignment: Alignment.center,
    );
  }
}

//  Add this extension method to get color based on index
extension JobCardColorExtension on List<Color> {
  Color getColorForIndex(int index) {
    return this[index % length];
  }
}




// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../../Data/Response/status.dart';
// import '../../View_Model/Jobs_View_Model/appliedJobs_view_model.dart';
// import '../../View_Model/Jobs_View_Model/filterjobs_view_model.dart';
// import '../../View_Model/Jobs_View_Model/savedJobs_view_model.dart';
// import '../../Widgets/jobCard.dart';

// // jobs_screen.dart
// class JobsScreen extends StatefulWidget {
//   const JobsScreen({super.key});

//   @override
//   State<JobsScreen> createState() => _JobsScreenState();
// }

// class _JobsScreenState extends State<JobsScreen> {
//   String selectedFilter = 'Discover';
//   final TextEditingController _searchController = TextEditingController();
//   late Future<void> fetchDataFuture;
//   String clientId = '1';
//   String ipAddress = '103.241.225.195';
//   String limit = '10';
//   String offset = '0';
//   String token =
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczOTQ0NDI4MywiaWF0IjoxNzM5MzU3ODgzLCJqdGkiOiJjYjA0YjEwZTZmMTA0YTZiYmIwYmJjZTZmNmQ5Yzk2NyIsInVzZXJfaWQiOjEwLCJ1c2VyTmFtZSI6IlByYWthc2ggUGF0ZWwiLCJjbGllbnRfaWQiOjEsImNsaWVudF9uYW1lIjoiQmhhcmdhdiBTb2xhbmtpIiwiY29tcGFueV9uYW1lIjoiU2tpbGwgQ29kZSBIdWIifQ.5VPX45OdimTzJh4todjMUokWcpEExHgbZYIS_7p_v0k";

//   final List<Color> jobCardColors = [
//     Color(0xFF5B4DFF),
//     Color(0xFFFF385C),
//     Color(0xFFFFB100),
//   ];
//   Timer? _debounce;
//   List<dynamic> filteredSavedJobs = [];
//   List<dynamic> filteredAppliedJobs = [];
//   List<dynamic> filteredClosedJobs = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFuture = fetchData();
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }

// // void _onSearchChanged() {
// //   if (_debounce?.isActive ?? false) _debounce!.cancel();
// //   _debounce = Timer(const Duration(milliseconds: 500), () {
// //     // Call API with search query
// //     _performSearch(_searchController.text);
// //   });
// // }

//   void _onSearchChanged() {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       if (selectedFilter == 'Discover') {
//         _performSearch(_searchController.text);
//       } else {
//         _performLocalSearch(_searchController.text);
//       }
//     });
//   }

//   void _performSearch(String query) {
//     Map<String, String> data = {
//       "jobTitle": query.trim(), // Search query
//       "jobType": "",
//       "city": "",
//       "salary": "",
//       "employementType": ""
//     };

//     final filterJobsViewmodel =
//         Provider.of<FilterJobsViewmodel>(context, listen: false);
//     filterJobsViewmodel.fetchFilterJobsApi(limit, offset, clientId.toString(),
//         ipAddress.toString(), data, token.toString());
//   }

// // Add this method to handle local filtering
//   void _performLocalSearch(String query) {
//     final searchQuery = query.toLowerCase();

//     setState(() {
//       switch (selectedFilter) {
//         case 'Saved':
//           final getSavedJobsListViewmodel =
//               Provider.of<GetSavedJobsListViewmodel>(context, listen: false);
//           if (getSavedJobsListViewmodel.getSavedJobsList.data?.userSavedJobs !=
//               null) {
//             filteredSavedJobs = getSavedJobsListViewmodel
//                 .getSavedJobsList.data!.userSavedJobs!
//                 .where((job) =>
//                     job.jobDetails!.jobTitle
//                         .toString()
//                         .toLowerCase()
//                         .contains(searchQuery) ||
//                     job.jobDetails!.companyDetails!.companyName
//                         .toString()
//                         .toLowerCase()
//                         .contains(searchQuery) ||
//                     job.jobDetails!.jobCity
//                         .toString()
//                         .toLowerCase()
//                         .contains(searchQuery) ||
//                     job.jobDetails!.jobDescription
//                         .toString()
//                         .toLowerCase()
//                         .contains(searchQuery))
//                 .toList();
//           }
//           break;

//         case 'Applied':
//           final getAppliedJobsListViewmodel =
//               Provider.of<GetAppliedJobsListViewmodel>(context, listen: false);
//           if (getAppliedJobsListViewmodel
//                   .getAppliedJobsList.data?.appliedJobs !=
//               null) {
//             filteredAppliedJobs = getAppliedJobsListViewmodel
//                 .getAppliedJobsList.data!.appliedJobs!
//                 .where((job) =>
//                     job.jobDetails!.jobTitle
//                         .toString()
//                         .toLowerCase()
//                         .contains(searchQuery) ||
//                     job.jobDetails!.companyDetails!.companyName
//                         .toString()
//                         .toLowerCase()
//                         .contains(searchQuery) ||
//                     job.jobDetails!.jobCity
//                         .toString()
//                         .toLowerCase()
//                         .contains(searchQuery) ||
//                     job.jobDetails!.jobDescription
//                         .toString()
//                         .toLowerCase()
//                         .contains(searchQuery))
//                 .toList();
//           }
//           break;

//         case 'Closed':
//           final getSavedJobsListViewmodel =
//               Provider.of<GetSavedJobsListViewmodel>(context, listen: false);
//           if (getSavedJobsListViewmodel.getSavedJobsList.data?.userSavedJobs !=
//               null) {
//             filteredClosedJobs = getSavedJobsListViewmodel
//                 .getSavedJobsList.data!.userSavedJobs!
//                 .where((job) =>
//                     job.jobDetails!.isActive.toString() != "Active" &&
//                     (job.jobDetails!.jobTitle
//                             .toString()
//                             .toLowerCase()
//                             .contains(searchQuery) ||
//                         job.jobDetails!.companyDetails!.companyName
//                             .toString()
//                             .toLowerCase()
//                             .contains(searchQuery) ||
//                         job.jobDetails!.jobCity
//                             .toString()
//                             .toLowerCase()
//                             .contains(searchQuery) ||
//                         job.jobDetails!.jobDescription
//                             .toString()
//                             .toLowerCase()
//                             .contains(searchQuery)))
//                 .toList();
//           }
//           break;
//       }
//     });
//   }

//   Future<void> fetchData() async {
//     await Future.delayed(Duration(microseconds: 20));
//     Map<String, String> data = {
//       "jobTitle": "",
//       "jobType": "",
//       "city": "",
//       "salary": "",
//       "employementType": ""

// // "sortingType": ""
//       //       "jobTitle": "Full Stack Intern",
//       // "jobType": "On-Site",
//       // "city": "Vadodara",
//       // "salary": "0-3",
//       // "employementType": "[3,1]"
//     };

//     final filterJobsViewmodel =
//         Provider.of<FilterJobsViewmodel>(context, listen: false);
//     filterJobsViewmodel.fetchFilterJobsApi(limit, offset, clientId.toString(),
//         ipAddress.toString(), data, token.toString());

//     final getSavedJobsListViewmodel =
//         Provider.of<GetSavedJobsListViewmodel>(context, listen: false);
//     getSavedJobsListViewmodel.fetchSavedJobsListApi(
//         ipAddress.toString(), token.toString());

//     final getAppliedJobsListViewmodel =
//         Provider.of<GetAppliedJobsListViewmodel>(context, listen: false);

//     getAppliedJobsListViewmodel.fetchAppliedJobsListApi(
//         ipAddress.toString(), token.toString());
//   }

//   // @override
//   // void dispose() {
//   //   _searchController.dispose();
//   //   super.dispose();
//   // }

//   // void _onFilterTap(String filter) {
//   //   setState(() {
//   //     selectedFilter = filter;
//   //   });
//   // }
//   void _onFilterTap(String filter) {
//     setState(() {
//       selectedFilter = filter;
//       // Reset search and filtered lists when changing tabs
//       if (filter != 'Discover') {
//         filteredSavedJobs = [];
//         filteredAppliedJobs = [];
//         filteredClosedJobs = [];
//         _performLocalSearch(_searchController.text);
//       }
//     });
//   }

//   Widget _buildFilterChip(String label) {
//     final isSelected = selectedFilter == label;

//     // Get count based on filter type
//     int count = 0;
//     switch (label) {
//       case 'Discover':
//         count = 0;
//         break;
//       case 'Saved':
//         count = 1;
//         break;
//       case 'Applied':
//         count = 2;
//         break;
//       case 'Closed':
//         count = 3;
//         break;
//     }

//     return GestureDetector(
//       onTap: () => _onFilterTap(label),
//       child: Container(
//         height: 40,
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xFF4A3AFF) : Colors.white,
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               label,
//               style: GoogleFonts.inter(
//                 color: isSelected ? Colors.white : Colors.black,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filterJobsViewmodel =
//         Provider.of<FilterJobsViewmodel>(context, listen: false);
//     final getSavedJobsListViewmodel =
//         Provider.of<GetSavedJobsListViewmodel>(context, listen: false);
//     final getAppliedJobsListViewmodel =
//         Provider.of<GetAppliedJobsListViewmodel>(context, listen: false);

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: FutureBuilder<void>(
//         future: fetchData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error occurred: ${snapshot.error}'));
//           } else {
//             return SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         RichText(
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Hello ${"UserData.userName"} ',
//                                 style: GoogleFonts.inter(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w500,
//                                   height: 1.2,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: '👋',
//                                 style: TextStyle(fontSize: 22),
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.person_outline_rounded),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Find Jobs',
//                       style: GoogleFonts.inter(
//                         color: Colors.white,
//                         fontSize: 34,
//                         fontWeight: FontWeight.w700,
//                         height: 1.2,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           _buildFilterChip('Discover'),
//                           _buildDivider(),
//                           _buildFilterChip('Saved'),
//                           _buildDivider(),
//                           _buildFilterChip('Applied'),
//                           _buildDivider(),
//                           _buildFilterChip('Closed'),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 24),
//                     Container(
//                       height: 48,
//                       padding: EdgeInsets.symmetric(horizontal: 12),
//                       decoration: BoxDecoration(
//                         color: Color(0xFF1C1C1E),
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.search,
//                               color: Color.fromARGB(255, 255, 255, 255),
//                               size: 20),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: TextField(
//                               controller: _searchController,
//                               decoration: InputDecoration(
//                                 hintText: 'Search for company...',
//                                 hintStyle: GoogleFonts.plusJakartaSans(
//                                   color: Color.fromARGB(255, 255, 255, 255),
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                                 border: InputBorder.none,
//                                 suffixIcon: _searchController.text.isNotEmpty
//                                     ? IconButton(
//                                         icon: Icon(Icons.clear,
//                                             color: Colors.white54),
//                                         onPressed: () {
//                                           _searchController.clear();
//                                           // Reset search when cleared
//                                           _performSearch("");
//                                         },
//                                       )
//                                     : null,
//                               ),
//                               style: GoogleFonts.plusJakartaSans(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           // Container(
//                           //   padding: EdgeInsets.all(8),
//                           //   decoration: BoxDecoration(
//                           //     color: Color(0xFF2C2C2E),
//                           //     borderRadius: BorderRadius.circular(8),
//                           //   ),
//                           //   child:
//                           //       Icon(Icons.tune, color: Colors.white, size: 18),
//                           // ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Builder(
//                         builder: (context) {
//                           switch (selectedFilter) {
//                             case 'Discover':
//                               return ChangeNotifierProvider<
//                                   FilterJobsViewmodel>.value(
//                                 value: filterJobsViewmodel,
//                                 child: Consumer<FilterJobsViewmodel>(
//                                   builder: (context, value, _) {
//                                     switch (value.filterJobsList.status!) {
//                                       case Status.LOADING:
//                                         return Center(
//                                             child: CircularProgressIndicator());
//                                       case Status.ERROR:
//                                         return Text(value.toString());
//                                       case Status.COMPLETED:
//                                         return _buildJobsList(
//                                           value.filterJobsList.data!
//                                               .companyJobsList!,
//                                         );
//                                     }
//                                   },
//                                 ),
//                               );

//                             case 'Saved':
//                               return ChangeNotifierProvider<
//                                   GetSavedJobsListViewmodel>.value(
//                                 value: getSavedJobsListViewmodel,
//                                 child: Consumer<GetSavedJobsListViewmodel>(
//                                   builder: (context, value, _) {
//                                     switch (value.getSavedJobsList.status!) {
//                                       case Status.LOADING:
//                                         return Center(
//                                             child: CircularProgressIndicator());
//                                       case Status.ERROR:
//                                         return Text(value.toString());
//                                       case Status.COMPLETED:

//                                         return value.getSavedJobsList.data!
//                                                 .userSavedJobs!.isEmpty
//                                             ? Center(
//                                                 child: Text(
//                                                   'No jobs found',
//                                                   style: GoogleFonts
//                                                       .plusJakartaSans(
//                                                     color: Colors.white54,
//                                                     fontSize: 16,
//                                                   ),
//                                                 ),
//                                               )
//                                             : ListView.builder(
// itemCount: _searchController.text.isEmpty 
//             ? value.getSavedJobsList.data!.userSavedJobs!.length
//             : filteredSavedJobs.length,
//         itemBuilder: (context, index) {
//           final job = _searchController.text.isEmpty
//               ? value.getSavedJobsList.data!.userSavedJobs![index]
//               : filteredSavedJobs[index];

//                                                   return JobCard(
//                                                     company: job
//                                                         .jobDetails!
//                                                         .companyDetails!
//                                                         .companyName
//                                                         .toString(),
//                                                     role: job
//                                                         .jobDetails!.jobTitle
//                                                         .toString(),
//                                                     location: job
//                                                         .jobDetails!.jobCity!
//                                                         .toString(),
//                                                     experience: '',
//                                                     jobType: job
//                                                         .jobDetails!
//                                                         .employmentType!
//                                                         .courseTypeName
//                                                         .toString(),
//                                                     description: job.jobDetails!
//                                                         .jobDescription
//                                                         .toString(),
//                                                     salary: job
//                                                             .jobDetails!.amount
//                                                             .toString() +
//                                                         " " +
//                                                         job.jobDetails!.payRate
//                                                             .toString(),
//                                                     color: jobCardColors
//                                                         .getColorForIndex(
//                                                             index),
//                                                     postedDate: job
//                                                         .jobDetails!.createdAt
//                                                         .toString(),
//                                                     keyQualifications: job
//                                                         .jobDetails!
//                                                         .keyQualifications
//                                                         .toString(),
//                                                   );
//                                                 },
//                                               );
//                                     }
//                                   },
//                                 ),
//                               );

//                             case 'Applied':
//                               return ChangeNotifierProvider<
//                                   GetAppliedJobsListViewmodel>.value(
//                                 value: getAppliedJobsListViewmodel,
//                                 child: Consumer<GetAppliedJobsListViewmodel>(
//                                   builder: (context, value, _) {
//                                     switch (value.getAppliedJobsList.status!) {
//                                       case Status.LOADING:
//                                         return Center(
//                                             child: CircularProgressIndicator());
//                                       case Status.ERROR:
//                                         return Text(value.toString());
//                                       case Status.COMPLETED:
//                                         return value.getAppliedJobsList.data!
//                                                 .appliedJobs!.isEmpty
//                                             ? Center(
//                                                 child: Text(
//                                                   'No jobs found',
//                                                   style: GoogleFonts
//                                                       .plusJakartaSans(
//                                                     color: Colors.white54,
//                                                     fontSize: 16,
//                                                   ),
//                                                 ),
//                                               )
//                                             : ListView.builder(
// itemCount: _searchController.text.isEmpty 
//             ? value.getAppliedJobsList.data!.appliedJobs!.length
//             : filteredAppliedJobs.length,
//         itemBuilder: (context, index) {
//           final job = _searchController.text.isEmpty
//               ? value.getAppliedJobsList.data!.appliedJobs![index]
//               : filteredAppliedJobs[index];

//                                                   return JobCard(
//                                                     company: job
//                                                         .jobDetails!
//                                                         .companyDetails!
//                                                         .companyName
//                                                         .toString(),
//                                                     role: job
//                                                         .jobDetails!.jobTitle!
//                                                         .toString(),
//                                                     location: job
//                                                         .jobDetails!.jobCity!
//                                                         .toString(),
//                                                     experience: '',
//                                                     jobType: job
//                                                         .jobDetails!
//                                                         .employmentType!
//                                                         .courseTypeName
//                                                         .toString(),
//                                                     description: job.jobDetails!
//                                                         .jobDescription
//                                                         .toString(),
//                                                     salary: job
//                                                             .jobDetails!.amount
//                                                             .toString() +
//                                                         " " +
//                                                         job.jobDetails!.payRate
//                                                             .toString(),
//                                                     color: jobCardColors
//                                                         .getColorForIndex(
//                                                             index),
//                                                     postedDate: job.createdAt
//                                                         .toString(),
//                                                     keyQualifications: job
//                                                         .jobDetails!
//                                                         .keyQualifications
//                                                         .toString(),
//                                                   );
//                                                 },
//                                               );
//                                     }
//                                   },
//                                 ),
//                               );

//                             case 'Closed':
//                               return ChangeNotifierProvider<
//                                   GetSavedJobsListViewmodel>.value(
//                                 value: getSavedJobsListViewmodel,
//                                 child: Consumer<GetSavedJobsListViewmodel>(
//                                   builder: (context, value, _) {
//                                     switch (value.getSavedJobsList.status!) {
//                                       case Status.LOADING:
//                                         return Center(
//                                             child: CircularProgressIndicator());
//                                       case Status.ERROR:
//                                         return Text(value.toString());
//                                       case Status.COMPLETED:
//                                         return value.getSavedJobsList.data!
//                                                 .userSavedJobs!.isEmpty
//                                             ? Center(
//                                                 child: Text(
//                                                   'No jobs found',
//                                                   style: GoogleFonts
//                                                       .plusJakartaSans(
//                                                     color: Colors.white54,
//                                                     fontSize: 16,
//                                                   ),
//                                                 ),
//                                               )
//                                             : ListView.builder(
//         itemCount: _searchController.text.isEmpty 
//             ? value.getSavedJobsList.data!.userSavedJobs!.length
//             : filteredClosedJobs.length,
//         itemBuilder: (context, index) {
//           final job = _searchController.text.isEmpty
//               ? value.getSavedJobsList.data!.userSavedJobs![index]
//               : filteredClosedJobs[index];

//                                                   return job.jobDetails!
//                                                               .isActive
//                                                               .toString() !=
//                                                           "Active"
//                                                       ? JobCard(
//                                                           company: job
//                                                               .jobDetails!
//                                                               .companyDetails!
//                                                               .companyName
//                                                               .toString(),
//                                                           role: job.jobDetails!
//                                                               .jobTitle
//                                                               .toString(),
//                                                           location: job
//                                                               .jobDetails!
//                                                               .jobCity!
//                                                               .toString(),
//                                                           experience: '',
//                                                           jobType: job
//                                                               .jobDetails!
//                                                               .employmentType!
//                                                               .courseTypeName
//                                                               .toString(),
//                                                           description: job
//                                                               .jobDetails!
//                                                               .jobDescription
//                                                               .toString(),
//                                                           salary: job
//                                                                   .jobDetails!
//                                                                   .amount
//                                                                   .toString() +
//                                                               " " +
//                                                               job.jobDetails!
//                                                                   .payRate
//                                                                   .toString(),
//                                                           color: jobCardColors
//                                                               .getColorForIndex(
//                                                                   index),
//                                                           postedDate: job
//                                                               .jobDetails!
//                                                               .createdAt
//                                                               .toString(),
//                                                           keyQualifications: job
//                                                               .jobDetails!
//                                                               .keyQualifications
//                                                               .toString(),
//                                                         )
//                                                       : Center(
//                                                           child: Text(
//                                                             'No jobs found',
//                                                             style: GoogleFonts
//                                                                 .plusJakartaSans(
//                                                               color: Colors
//                                                                   .white54,
//                                                               fontSize: 16,
//                                                             ),
//                                                           ),
//                                                         );
//                                                 },
//                                               );
//                                     }
//                                   },
//                                 ),
//                               );

//                             default:
//                               return Center(
//                                   child: Text('Invalid filter selected'));
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildJobsList(List companyJobsList) {
//     return companyJobsList.isEmpty
//         ? Center(
//             child: Text(
//               'No jobs found',
//               style: GoogleFonts.plusJakartaSans(
//                 color: Colors.white54,
//                 fontSize: 16,
//               ),
//             ),
//           )
//         : ListView.builder(
//             itemCount: companyJobsList.length,
//             itemBuilder: (context, index) {
//               final job = companyJobsList[index];
//               return JobCard(
//                 company: job.companyDetails!.companyName.toString(),
//                 role: job.jobTitle!.toString(),
//                 location: job.jobCity!.toString(),
//                 experience: job.requiredExperience!.toString(),
//                 jobType: job.employmentTypeDetails.courseTypeName.toString(),
//                 description: job.jobDescription.toString(),
//                 salary: job.amount.toString() + " " + job.payRate.toString(),
//                 color: jobCardColors.getColorForIndex(index),
//                 postedDate: job.createdAt.toString(),
//                 keyQualifications: job.keyQualifications.toString(),
//               );
//             },
//           );
//   }

//   Widget _buildDivider() {
//     return Container(
//       height: 9,
//       width: 20,
//       margin: EdgeInsets.symmetric(horizontal: 0),
//       color: Colors.white,
//       alignment: Alignment.center,
//     );
//   }
// }

// //  Add this extension method to get color based on index
// extension JobCardColorExtension on List<Color> {
//   Color getColorForIndex(int index) {
//     return this[index % length];
//   }
// }




