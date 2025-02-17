import 'package:flutter/material.dart';

import '../../SharedPreferences/sharePreference.dart';
import '../Login/loginScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
    UserPreferences userPreference = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [IconButton(onPressed: (){

                          userPreference.logoutProcess();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false);

        }, icon: Icon(Icons.logout_outlined))],

      ),
    );
  }
}
