import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../utils.dart';

class WaveLoaderWidget extends StatelessWidget {
  const WaveLoaderWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            child: Lottie.asset(
              // 'images/LoadingDots.json',
              'images/wavesLoading.json',
              // 'images/searchLoading.json',
              reverse: true,
              repeat: true,
              fit: BoxFit.cover,
            ),
          ),
          // Container(
          //   child: Lottie.asset(
          //     // 'images/LoadingDots.json',
          //     'images/wavesLoading.json',
          //     reverse: true,
          //     repeat: true,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Positioned(
            // top: 0,
            left: 12,
            right: 0,
            bottom: 6.h,
            child: Center(
              child: Text(
                'Loading...',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: descriptionFontSize,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
