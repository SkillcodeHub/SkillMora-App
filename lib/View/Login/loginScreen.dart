import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../View_Model/Auth_view_Model/login_view_model.dart';
import '../NavigationBar/navigationBar.dart';
import '../Registration/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailStr = TextEditingController();
  TextEditingController passwordStr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Color(0xFFCC1E602), // Light green background
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                // Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.w,
                      height: 9.h,
                      child: Image.asset(
                        'images/logo.png',
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40),
                // Login Text
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Email Id',
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                TextField(
                  controller: emailStr,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter your email ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
                SizedBox(height: 20),
                // Password Field

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Password',
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                TextField(
                  controller: passwordStr,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Login Button
                SizedBox(
                  width: 30.w,
                  child: ElevatedButton(
                    onPressed: () {
                      Map data = {
                        'username': emailStr.text.toString(),
                        'password': passwordStr.text.toString(),
                        'source': "Mobile",
                      };
                      authViewModel.loginApi(data, context);

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OtpVerificationScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Or Login With
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.black54)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Or Login With'),
                    ),
                    Expanded(child: Divider(color: Colors.black54)),
                  ],
                ),
                SizedBox(height: 20),
                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _socialLoginButton(
                      onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyNavigationBar(indexNumber: 0,)));

                      },
                      icon: Icons.facebook,
                      color: Colors.blue,
                    ),
                    _socialLoginButton(
                      onPressed: () {},
                      icon: Icons.mail,
                      color: Colors.red,
                    ),
                    _socialLoginButton(
                      onPressed: () {},
                      icon: Icons.apple,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have Account? "),
                    TextButton(
                      onPressed: () {


                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SkillmoraRegistration()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      color: color,
      iconSize: 32,
    );
  }
}
