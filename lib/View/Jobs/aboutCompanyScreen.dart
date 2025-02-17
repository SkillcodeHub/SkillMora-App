import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Data/Response/status.dart';
import '../../SharedPreferences/sharePreference.dart';
import '../../Utils/Routes/routes_name.dart';
import '../../View_Model/Jobs_View_Model/companyDetailsById_view_model.dart';

class AboutCompanyScreen extends StatefulWidget {
  final String companyId;

  AboutCompanyScreen({
    super.key,
    required this.companyId,
  });

  @override
  State<AboutCompanyScreen> createState() => _AboutCompanyScreenState();
}

class _AboutCompanyScreenState extends State<AboutCompanyScreen> {
  late Future<void> fetchDataFuture;
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
    fetchDataFuture = fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(microseconds: 20));
    final companyDetailsByIdViewmodel =
        Provider.of<CompanyDetailsByIdViewmodel>(context, listen: false);

    companyDetailsByIdViewmodel.fetchCompanyDetailsByIdApi(
        ipAddress.toString(), widget.companyId.toString(), token.toString());
  }

  @override
  Widget build(BuildContext context) {
    final companyDetailsByIdViewmodel =
        Provider.of<CompanyDetailsByIdViewmodel>(context, listen: false);

    return FutureBuilder<void>(
      future: fetchDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error occurred: ${snapshot.error}'));
        } else {
          return ChangeNotifierProvider<CompanyDetailsByIdViewmodel>.value(
              value: companyDetailsByIdViewmodel,
              child: Consumer<CompanyDetailsByIdViewmodel>(
                builder: (context, value, _) {
                  switch (value.companyDetailsById.status!) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(child: Text(value.toString()));
                    case Status.COMPLETED:
                      return Scaffold(
                        backgroundColor: Colors.black,
                        floatingActionButton: FloatingActionButton.extended(
                          onPressed: () {
                            Map data = {
                              'companyName': value.companyDetailsById.data!
                                  .comapnyDetail![0].companyName
                                  .toString(),
                              'companyId': value
                                  .companyDetailsById.data!.comapnyDetail![0].id
                                  .toString(),
                            };
                            Navigator.pushNamed(
                                context, RoutesName.addReviewScreen,
                                arguments: data);
                          },
                          backgroundColor: Color(0xFFCCFF00),
                          icon: Icon(Icons.rate_review, color: Colors.black),
                          label: Text(
                            'Add Review',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
                                      icon: Icon(Icons.arrow_back,
                                          color: Colors.white),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'About Company',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Company Info Section
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
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
                                        value.companyDetailsById.data!
                                            .comapnyDetail![0].companyLogo
                                            .toString(),
                                        fit: BoxFit
                                            .cover, // Change from contain to cover
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Container(
                                      width: 70.w,
                                      child: Text(
                                        value.companyDetailsById.data!
                                            .comapnyDetail![0].companyName
                                            .toString(),
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Response Time Card
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(24),
                                    bottomRight: Radius.circular(24),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Usually Replies',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          'in 1 day.',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 24),
                                    Container(
                                      width: 3,
                                      height: 40,
                                      color: Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.3),
                                    ),
                                    SizedBox(width: 24),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(5, (index) {
                                              print(value
                                                  .companyDetailsById
                                                  .data!
                                                  .comapnyDetail![0]
                                                  .companyRating);
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    color: index <
                                                            value
                                                                .companyDetailsById
                                                                .data!
                                                                .comapnyDetail![
                                                                    0]
                                                                .companyRating
                                                                .toInt()
                                                        ? Color(0xFFCCFF00)
                                                        : Colors.grey
                                                            .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Icon(
                                                    Icons.description_outlined,
                                                    color: index <
                                                            value
                                                                .companyDetailsById
                                                                .data!
                                                                .comapnyDetail![
                                                                    0]
                                                                .companyRating
                                                                .toInt()
                                                        ? Colors.black
                                                        : Colors.grey,
                                                    size: 16,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            '${value.companyDetailsById.data!.comapnyDetail![0].companyReviewsDetails!.length.toString()} Reviewers',
                                            style: GoogleFonts.plusJakartaSans(
                                              color: Colors.black54,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Company Details
                              Expanded(
                                child: ListView(
                                  padding: EdgeInsets.all(16),
                                  children: [
                                    _buildDetailItem(
                                      value.companyDetailsById.data!
                                          .comapnyDetail![0].companyName
                                          .toString(),
                                      value.companyDetailsById.data!
                                          .comapnyDetail![0].companyDescription
                                          .toString(),
                                      Icons.check_circle_outline,
                                    ),
                                    _buildDetailItem(
                                      'Industry',
                                      value
                                          .companyDetailsById
                                          .data!
                                          .comapnyDetail![0]
                                          .industryTypeDetails!
                                          .typeName
                                          .toString(),
                                      Icons.business_outlined,
                                    ),
                                    _buildDetailItem(
                                      'Website',
                                      value.companyDetailsById.data!
                                          .comapnyDetail![0].companyWebsite
                                          .toString(),
                                      Icons.language_outlined,
                                    ),
                                    _buildDetailItem(
                                      'Company Size',
                                      value.companyDetailsById.data!
                                          .comapnyDetail![0].noOfEmployee
                                          .toString(),
                                      Icons.people_outline,
                                    ),
                                    _buildDetailItem(
                                      'Headquaters',
                                      value
                                              .companyDetailsById
                                              .data!
                                              .comapnyDetail![0]
                                              .companyLocationsDetails![0]
                                              .city
                                              .toString() +
                                          ',' +
                                          value
                                              .companyDetailsById
                                              .data!
                                              .comapnyDetail![0]
                                              .companyLocationsDetails![0]
                                              .state
                                              .toString(),
                                      Icons.location_on_outlined,
                                    ),
                                    _buildDetailItem(
                                      'Founded',
                                      value
                                          .companyDetailsById
                                          .data!
                                          .comapnyDetail![0]
                                          .companyFoundationYear
                                          .toString(),
                                      Icons.calendar_today_outlined,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                  }
                },
              ));
        }
      },
    );
  }

  Widget _buildDetailItem(String title, String content, IconData icon) {
    final companyDetailsByIdViewmodel =
        Provider.of<CompanyDetailsByIdViewmodel>(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Color.fromARGB(255, 252, 252, 252),
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFFCCFF00),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                // Check if this is the company description
                title ==
                        companyDetailsByIdViewmodel.companyDetailsById.data!
                            .comapnyDetail![0].companyName
                            .toString()
                    ? Html(
                        data: content,
                        style: {
                          "p": Style(
                            color: Colors.white,
                            fontSize: FontSize(14),
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                            lineHeight: LineHeight(1.5),
                          ),
                        },
                      )
                    : Text(
                        content,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
