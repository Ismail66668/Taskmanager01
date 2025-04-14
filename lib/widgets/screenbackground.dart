import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/assetspath.dart';

// ignore: must_be_immutable
class Screenbackground extends StatelessWidget {
  Screenbackground({super.key, required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          height: double.maxFinite,
          width: double.maxFinite,
          AssetsPath.bagroundSvg,
          fit: BoxFit.cover,
        ),
        child
      ],
    );
  }
}
