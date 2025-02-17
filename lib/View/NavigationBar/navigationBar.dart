import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../SharedPreferences/sharePreference.dart';
import '../Jobs/JobsScreen.dart';
import '../Jobs/appliedJobsListScreen.dart';
import '../Notifications/notificationListScreen.dart';
import '../Profile/profileScreen.dart';
import '../Review/reviewScreen.dart';

class MyNavigationBar extends StatefulWidget {
  final int indexNumber;

 const  MyNavigationBar({Key? key, required this.indexNumber}) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  double iconSize = 20;
  dynamic UserData;
  String? usertype;
  UserPreferences userPreference = UserPreferences();

  @override
  void initState() {
    userPreference.getUserData().then((value) {
      setState(() {
        UserData = value!;
        usertype = UserData['data']['usertype'].toString();
        print('usertype : $usertype');
      });
    });
    super.initState();
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index, ValueNotifier<int> selectedIndexProvider) {
    final bool isSelected = selectedIndexProvider.value == index;
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        selectedIndexProvider.value = index;
      },
      child: TweenAnimationBuilder(
        duration:  Duration(milliseconds: 200),
        tween: Tween<double>(begin: 1, end: isSelected ? 1.2 : 1),
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              padding:  EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ?  Color(0xFFCCFF00) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.black : Colors.white,
                size: iconSize,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<int>>(
      create: (_) => ValueNotifier<int>(widget.indexNumber),
      child: Consumer<ValueNotifier<int>>(
        builder: (context, selectedIndexProvider, _) {
          final selectedIndex = selectedIndexProvider.value;

          final List<Widget> user = [
            JobsScreen(),
            AddReviewScreen(data: null),
            NotificationScreen(),
            ProfileScreen(),
          ];

          return Scaffold(
            body: user[selectedIndex],
            bottomNavigationBar: Container(
              padding:  EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset:  Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(context, Icons.work_outline, 0, selectedIndexProvider),
                  _buildNavItem(context, Icons.edit_note, 1, selectedIndexProvider),
                  _buildNavItem(context, Icons.notifications_outlined, 2, selectedIndexProvider),
                  _buildNavItem(context, Icons.person_outline, 3, selectedIndexProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}