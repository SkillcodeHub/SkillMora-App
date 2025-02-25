import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'View/Splash/splashServices.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  SplashServices splasheSrvices = SplashServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCC1E602), // Lime green background
      body: Container(
        height: 100.h,
        child: Column(
          children: [
            Container(
              height: 60.h,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
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
                    Center(
                      child: Text(
                        'Your search for\nthe next dream\njob is over 🚀',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Text(
                    //   '🚀',
                    //   style: TextStyle(fontSize: 24),
                    // ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      onPressed: () {
                        splasheSrvices.checkAuthentication(context);

                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start Searching',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),

                    // Expanded(
                    //   child: Stack(
                    //     children: [
                    //       _buildCompanyLogo('Airbnb', const Color(0xFFFF5A5F), Alignment.topLeft),
                    //       _buildCompanyLogo('Meta', Colors.black87, Alignment.topCenter),
                    //       _buildCompanyLogo('Microsoft', Colors.black87, Alignment(0.5, -0.8)),
                    //       _buildCompanyLogo('Goldman Sachs', Colors.black87, Alignment(-0.5, -0.4)),
                    //       _buildCompanyLogo('Tesla', const Color(0xFFE82127), Alignment(0.8, -0.4)),
                    //       _buildCompanyLogo('Apple', Colors.black87, Alignment(-0.8, 0)),
                    //       _buildCompanyLogo('PepsiCo', Colors.black87, Alignment(0, 0)),
                    //       _buildCompanyLogo('J.P. Morgan', Colors.black87, Alignment(0.8, 0)),
                    //       _buildCompanyLogo('Google', Colors.black87, Alignment(-0.5, 0.4)),
                    //       _buildCompanyLogo('Swiggy', const Color(0xFFFC8019), Alignment(0.5, 0.4)),
                    //       _buildCompanyLogo('Uber', Colors.black87, Alignment(-0.8, 0.8)),
                    //       _buildCompanyLogo('LinkedIn', const Color(0xFF0077B5), Alignment(0, 0.8)),
                    //       _buildCompanyLogo('Bank of America', Colors.black87, Alignment(0.8, 0.8)),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Container(
              width: 100.w,
              height: 37.h,
              child: Image.asset(
                'images/companyImages.png',
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyLogo(String name, Color color, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: name.length % 2 == 0 ? 0.1 : -0.1, // Slight random rotation
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (name == 'Google')
                Icon(Icons.search, color: Colors.white, size: 16),
              if (name == 'Apple')
                Icon(Icons.apple, color: Colors.white, size: 16),
              if (name == 'Meta')
                Icon(Icons.facebook, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
