import 'package:flutter/material.dart';

@immutable
class Solid {
  final Color main1 = const Color(0xFFFBA92D);
  final Color main2 = const Color(0xFFFF9900);
  final Color dark = const Color(0xFF000000);
  final Color dark50 = const Color(0x80000000);
  final Color light = const Color(0xFFFFFFFF);
  final Color light50 = const Color(0x80FFFFFF);

  const Solid();
}

@immutable
class Muliple {
  final Gradient bg = LinearGradient(
    colors: [
      AppColor.slid.main1,
      AppColor.slid.main2.withOpacity(0.5),
    ],
    // stops: const [0.3, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // final Gradient bg = RadialGradient(
  //   colors: [
  //     AppColor.slid.main1,
  //     AppColor.slid.main2.withOpacity(0),
  //   ],
  //   // stops: const [0.3, 1.0],
  //   center: Alignment.center,
  //   radius: 0.5,
  // );

  Muliple();
}

@immutable
class AppColor {
  static const slid = Solid();
  static var grdnt = Muliple();

  const AppColor();
}
