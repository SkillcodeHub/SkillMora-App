import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils.dart';

class ScreenNameWidget extends StatelessWidget {
  final String title;

  const ScreenNameWidget({
    super.key,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return SizerUtil.deviceType == DeviceType.mobile
        ? Container(
            // width: 48.w,
            width: 52.w,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: headerFontSize,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        : Container(
            // height: 6.h,
            width: 70.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
  }
}
