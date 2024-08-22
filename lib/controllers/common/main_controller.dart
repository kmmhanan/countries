import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  static const Transition transitionType = Transition.fadeIn;
  static const Duration transitionDuration = Duration(milliseconds: 300);

  void navTo(Widget goTo) {
    Get.to(
      () => goTo,
      transition: transitionType,
      duration: transitionDuration,
    );
  }

  void nameNavTo(String goTo) {
    Get.toNamed(
      goTo,
    );
  }

  void spNavTo(String goTo) {
    Get.offAllNamed(
      goTo,
    );
  }

  String formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'),
          (match) => '${match[1]},',
        );
  }
}
