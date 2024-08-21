import 'package:countries/controllers/api/country_controller.dart';
import 'package:countries/theme/color_theme.dart';
import 'package:countries/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Paginator extends StatelessWidget {
  const Paginator({super.key});

  @override
  Widget build(BuildContext context) {
    final CountryController cntry = Get.find();

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => cntry.previousPage(),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColor.slid.dark50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: AppColor.slid.light,
                        ),
                        Text(
                          'Previous',
                          style: Theme.of(context).textTheme.normal16,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 56),
              Expanded(
                child: GestureDetector(
                  onTap: () => cntry.nextPage(),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColor.slid.dark50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: Theme.of(context).textTheme.normal16,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColor.slid.light,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: -16,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColor.slid.light,
                borderRadius: BorderRadius.circular(16),
              ),
            ))
      ],
    );
  }
}
