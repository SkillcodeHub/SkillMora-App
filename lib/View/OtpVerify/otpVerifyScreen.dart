import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../View_Model/Auth_view_Model/verifyOtp_view_model.dart';

class OtpVerificationScreen extends StatefulWidget {
  final dynamic data;

  const OtpVerificationScreen({super.key, required this.data});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6, // Changed to 6 digits
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(
    6, // Changed to 6 digits
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleKeyPress(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (_controllers[index].text.isEmpty && index > 0) {
          // If current field is empty and backspace is pressed, move to previous field
          _controllers[index - 1].clear();
          _focusNodes[index - 1].requestFocus();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final verifyOtpViewModel = Provider.of<VerifyOtpViewModel>(context);

    return Scaffold(
      backgroundColor: Color(0xFFCC1E602),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 8.h),
              // OTP Verification Text
              Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Enter verification code we just sent on\nyour email id / phone number',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 30),
              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6, // Changed to 6 digits
                  (index) => Container(
                    width: 45, // Slightly reduced width to accommodate 6 boxes
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) => _handleKeyPress(event, index),
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.length == 1 && index < 5) {
                            // Move to next field
                            _focusNodes[index + 1].requestFocus();
                          } else if (value.isEmpty && index > 0) {
                            // Move to previous field on backspace
                            _focusNodes[index - 1].requestFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Verify Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ProfileDetailsScreen(),
                    //   ),
                    // );
                    String otp = _controllers
                        .map((controller) => controller.text)
                        .join();
                    if (otp.length == 6) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ProfileDetailsScreen(),
                      //   ),
                      // );

                      Map data = {
                        'name': widget.data['name'].toString(),
                        'password': widget.data['password'].toString(),
                        'mobile': widget.data['mobile'].toString(),
                        'workStatus': widget.data['workStatus'].toString(),
                        'currentCity': widget.data['currentCity'].toString(),
                        'resumeFile': widget.data['resumeFile'].toString(),
                        'email': widget.data['email'].toString(),
                        'otp': otp.toString(),
                      };
                      verifyOtpViewModel.verifyOtpApi(data, context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'VERIFY',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Resend Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't Received Code? ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend',
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
    );
  }
}
