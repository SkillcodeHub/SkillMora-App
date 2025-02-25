import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Data/Response/status.dart';
import '../../Models/NotificationLIst_Model/notificationList_model.dart';
import '../../SharedPreferences/sharePreference.dart';
import '../../View_Model/Notification_View_Model/notificationList_view_model.dart';


class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<void> fetchDataFuture;
  String ipAddress = '103.241.225.195';
  String? token;
  UserPreferences userPreference = UserPreferences();
  dynamic UserData;

  // Data structures to hold grouped notifications
  Map<String, List<dynamic>> groupedNotifications = {
    'Today': [],
    'Last Week': [],
    'Older': []
  };

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
    final notificationListViewmodel =
        Provider.of<NotificationListViewmodel>(context, listen: false);

    await notificationListViewmodel.fetchNotificationListApi(
        ipAddress.toString(), token.toString());
  }




  List<dynamic> sortNotificationsByDate(List<Notifications>? notifications) {
    notifications!.sort((a, b) {
      DateTime dateA = DateTime.parse(a.createdAt.toString());
      DateTime dateB = DateTime.parse(b.createdAt.toString());
      return dateB.compareTo(dateA); // Sort in descending order (newest first)
    });
    return notifications;
  }

  // Function to group notifications by date
  void groupNotificationsByDate(List<Notifications> ? notifications) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastWeek = today.subtract(Duration(days: 7));

    groupedNotifications = {
      'Today': [],
      'Last Week': [],
      'Older': []
    };

    for (var notification in notifications!) {
      final createdAt = DateTime.parse(notification.createdAt.toString());
      final notificationDate = DateTime(
          createdAt.year, createdAt.month, createdAt.day);

      if (notificationDate.isAtSameMomentAs(today)) {
        groupedNotifications['Today']!.add(notification);
      } else if (notificationDate.isAfter(lastWeek) &&
          notificationDate.isBefore(today)) {
        groupedNotifications['Last Week']!.add(notification);
      } else {
        groupedNotifications['Older']!.add(notification);
      }
    }
        // Sort each group by date
    groupedNotifications['Today'] = sortNotificationsByDate(groupedNotifications['Today']!.cast<Notifications>());
    groupedNotifications['Last Week'] = sortNotificationsByDate(groupedNotifications['Last Week']!.cast<Notifications>());
    groupedNotifications['Older'] = sortNotificationsByDate(groupedNotifications['Older']!.cast<Notifications>());

  }

  @override
  Widget build(BuildContext context) {
    final notificationListViewmodel =
        Provider.of<NotificationListViewmodel>(context, listen: false);

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
            return ChangeNotifierProvider<NotificationListViewmodel>.value(
              value: notificationListViewmodel,
              child: Consumer<NotificationListViewmodel>(
                builder: (context, value, _) {
                  switch (value.notificationList.status!) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(child: Text(value.toString()));
                    case Status.COMPLETED:
                      // Group notifications when data is loaded
                      groupNotificationsByDate(
                          value.notificationList.data!.notifications);

                      return SafeArea(
                        child: Column(
                          children: [
                            // Header
                            Container(
                              color: Colors.black,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // Icon(
                                      //   Icons.arrow_back,
                                      //   color: Colors.white,
                                      //   size: 24,
                                      // ),
                                      SizedBox(width: 16),
                                      Text(
                                        'Notification',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Icon(
                                  //   Icons.pause,
                                  //   color: Colors.white,
                                  //   size: 24,
                                  // ),
                                ],
                              ),
                            ),

                            // Content
                            Expanded(
                              child: Container(
                                color: Color(0xFFCCFF00),
                                child: Stack(
                                  children: [
                                    // Vertical Line
                                    Positioned(
                                      left: 24,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 1,
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                    ),

                                    // Content List
                                    ListView(
                                      padding: EdgeInsets.zero,
                                      children: [
                                        // Today's notifications
                                        if (groupedNotifications['Today']!
                                            .isNotEmpty) ...[
                                          _buildDateSection('Today'),
                                          ...groupedNotifications['Today']!
                                              .map((notification) =>
                                                  _buildNotificationItem(
                                                      notification))
                                              .toList(),
                                        ],

                                        // Last week's notifications
                                        if (groupedNotifications['Last Week']!
                                            .isNotEmpty) ...[
                                          _buildDateSection('Last Week'),
                                          ...groupedNotifications['Last Week']!
                                              .map((notification) =>
                                                  _buildNotificationItem(
                                                      notification))
                                              .toList(),
                                        ],

                                        // Older notifications
                                        if (groupedNotifications['Older']!
                                            .isNotEmpty) ...[
                                          _buildDateSection('Older'),
                                          ...groupedNotifications['Older']!
                                              .map((notification) =>
                                                  _buildNotificationItem(
                                                      notification))
                                              .toList(),
                                        ],
                                      ],
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

  Widget _buildDateSection(String date) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 24, 16, 16),
      child: Text(
        date,
        style: GoogleFonts.inter(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildNotificationItem(Notifications notification) {
    // Calculate time ago
    final createdAt = DateTime.parse(notification.createdAt.toString());
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    String timeAgo;

    if (difference.inDays > 0) {
      timeAgo = '${difference.inDays} days\nAgo';
    } else if (difference.inHours > 0) {
      timeAgo = '${difference.inHours} hrs\nAgo';
    } else {
      timeAgo = '${difference.inMinutes} mins\nAgo';
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
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
                                  notification.companyDetails!.companyLogo.toString(),
                                  fit: BoxFit
                                      .cover, // Change from contain to cover
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                  SizedBox(width: 12),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                notification.message ?? '',
                                style: TextStyle(
                                  color: Color(0xFFCCFF00),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            Text(
                              timeAgo,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          notification.type ?? '',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}