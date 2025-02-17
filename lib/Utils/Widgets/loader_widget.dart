import 'package:flutter/material.dart';
import 'package:skillmoraapp/Utils/Widgets/spining_lines.dart';

import '../../Res/colors.dart';

class LoaderWidget extends StatelessWidget {
  final double? size;

  LoaderWidget({this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(color: primaryColor, size: size ?? 70);
  }
}
