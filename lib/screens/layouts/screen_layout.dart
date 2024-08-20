import 'package:countries/theme/color_theme.dart';
import 'package:countries/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';

class ScreenLayout extends StatelessWidget {
  ScreenLayout({
    this.appBarTitle,
    this.onBackPressed,
    this.backButtonActive = true,
    required this.child,
    super.key,
  });

  final String? appBarTitle;
  final Widget child;
  final bool? backButtonActive;
  void Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.slid.dark,
      appBar: AppBar(
        automaticallyImplyLeading: backButtonActive!,
        leading: backButtonActive!
            ? IconButton(
                onPressed: onBackPressed ?? Get.back,
                icon: Icon(
                  Icons.arrow_circle_left,
                  color: AppColor.slid.light,
                  size: 40,
                ),
              )
            : null,
        actionsIconTheme: const IconThemeData(),
        backgroundColor: AppColor.slid.main1,
        title: Text(
          appBarTitle ?? '',
          style: Theme.of(context).textTheme.bold24,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColor.grdnt.bg,
        ),
        child: child,
      ),
    );
  }
}
