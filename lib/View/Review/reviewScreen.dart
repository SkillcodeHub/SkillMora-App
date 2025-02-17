import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../SharedPreferences/sharePreference.dart';
import '../../View_Model/Review_View_Model/addReview_view_model.dart';

class AddReviewScreen extends StatefulWidget {
  final dynamic data;
  AddReviewScreen({super.key, required this.data});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  int selectedRating = 0;
  String ipAddress = '103.241.225.195';
  String? token;
  UserPreferences userPreference = UserPreferences();
  dynamic UserData;
  final reviewstr = TextEditingController();
  String? userId;
  String? name;

  @override
  void initState() {
    userPreference.getUserData().then((value) {
      setState(() {
        UserData = value!;
        token = UserData['refresh'].toString();
        userId = UserData['user']['id'].toString();
        name = userId = UserData['user']['name'].toString();
        print(' Token : $token');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addReviewViewModel =
        Provider.of<AddReviewViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Review',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Company Logo and Name
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // child: Image.asset(
                    //   widget.logoPath,
                    //   width: 24,
                    //   height: 24,
                    // ),
                  ),
                  SizedBox(width: 12),
                  Text(
                   widget.data['companyName'].toString(),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Review Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'How was your\noverall experience\nwith ${widget.data['companyName'].toString()}?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
              ),

              SizedBox(height: 32),

              // Rating Section
              Text(
                'Your Overall Rating',
                style: GoogleFonts.inter(
                  color: Color(0xFFCCFF00),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRating = index + 1;

                        print(selectedRating);
                      });
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: index < selectedRating
                              ? Color(0xFFCCFF00)
                              : Colors.white.withOpacity(0.3),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        color: index < selectedRating
                            ? Color(0xFFCCFF00)
                            : Colors.white.withOpacity(0.3),
                        size: 24,
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: 32),

              // Additional Review Section
              Text(
                'Additional Review',
                style: GoogleFonts.inter(
                  color: Color(0xFFCCFF00),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: reviewstr,
                  style: GoogleFonts.inter(color: Colors.white),
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write your review here...',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),

              Spacer(),

              // Save Button
              Container(
                width: double.infinity,
                height: 56,
                margin: EdgeInsets.only(bottom: 24),
                child: ElevatedButton(
                  onPressed: () {
                    Map<String, String> data = {
                      'userId': userId.toString(),
                      'companyId': widget.data['companyId'].toString(),
                      'name': name.toString(),
                      'rating': selectedRating.toString(),
                      'comment': reviewstr.text,
                    };

                    addReviewViewModel.AddReviewApi(
                        ipAddress.toString(), token.toString(), data, context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFCCFF00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Save',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
