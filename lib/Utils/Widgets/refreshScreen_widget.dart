import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils.dart';

class RefreshScreenWidget extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final String noDataText;

  RefreshScreenWidget({
    required this.onRefresh,
    required this.noDataText,
  });

  @override
  State<RefreshScreenWidget> createState() => _RefreshScreenWidgetState();
}

class _RefreshScreenWidgetState extends State<RefreshScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            // physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                height: 74.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Swipe down to refresh page',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        color: Color(0XFF545454),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: Image.asset(
                        'images/result_not_found.png',
                        height: 15.h,
                        // width: 90,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Center(
                      child: Text(
                        widget.noDataText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          color: Color(0XFF545454),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
