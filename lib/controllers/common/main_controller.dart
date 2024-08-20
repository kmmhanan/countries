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
}
